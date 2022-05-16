import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/models/post.dart';
import 'package:note_app/models/user.dart';

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
