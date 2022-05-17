import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/models/post.dart';
import 'package:note_app/models/user.dart';

import '../locator.dart';
import '../viewmodels/application_view_model.dart';

class FireStoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _postsCollectionReference =
      FirebaseFirestore.instance.collection('posts');

  final StreamController<List<Post>> _postsController =
      StreamController<List<Post>>.broadcast();

  Future createUser(Users user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getUser(String uid) async {
    try {
      final userDoc = await _usersCollectionReference.doc(uid).get();
      final userData = userDoc.data();
      debugPrint("User: ${userData.toString()}");

      return Users.fromData(userData as Map<String, dynamic>);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future addPost(Post post) async {
    try {
      await _postsCollectionReference.add(post.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future deletePost(String documentId) async {
    try {
      await _postsCollectionReference.doc(documentId).delete();
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getPostsOnceOff() async {
    try {
      var postDocumentSnapshot = await _postsCollectionReference.get();
      if (postDocumentSnapshot.docs.isNotEmpty) {
        return postDocumentSnapshot.docs
            .map((snapshot) => Post.fromMap(
                snapshot.data() as Map<String, dynamic>, snapshot.id))
            .where((mappedItem) => mappedItem!.title != null)
            .toList();
      }
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Stream listenToPostsRealTime() {
    var apv = locator<AppplicationViewModel>();
    // Register the handler for when the posts data changes
    _postsCollectionReference.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.docs.isNotEmpty) {
        var posts = postsSnapshot.docs
            .map((snapshot) => Post.fromMap(
                snapshot.data() as Map<String, dynamic>, snapshot.id))
            .where(
                (pi) => pi?.title != null && pi?.userId == apv.currentUser?.id)
            .toList();

        // Add the posts onto the controller
        if (posts.isNotEmpty) {
          _postsController.add(posts.cast());
        }
      }
    });

    return _postsController.stream;
  }

  Future updatePost(Post post) async {
    try {
      await _postsCollectionReference.doc(post.documentId).update(post.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
}
