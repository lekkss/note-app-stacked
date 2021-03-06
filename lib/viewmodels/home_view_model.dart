import 'package:note_app/models/post.dart';
import 'package:note_app/services/navigation_services.dart';
import 'package:note_app/ui/views/create_post.dart';
import 'package:note_app/ui/views/edit_post.dart';
import 'package:note_app/viewmodels/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

import '../locator.dart';
import '../services/firestore_service.dart';

class HomeViewModel extends BaseModel {
  final MyNavigationServices _navigationService =
      locator<MyNavigationServices>();
  final FireStoreService _fireStoreService = locator<FireStoreService>();
  final DialogService dialogService = locator<DialogService>();

  List<Post>? _post;
  List<Post>? get post => _post;

  void listenToPosts() {
    setBusy(true);

    _fireStoreService.listenToPostsRealTime().listen((postsData) {
      List<Post> updatedPosts = postsData;
      if (updatedPosts.isNotEmpty) {
        _post = updatedPosts;
        notifyListeners();
      }

      setBusy(false);
    });
  }

  Future deletePost(int index) async {
    var postToDelete = _post![index];
    setBusy(true);
    await _fireStoreService.deletePost(postToDelete.documentId!);
    // Delete the image after the post is deleted
    setBusy(false);
    // }
  }

  Future navigateToCreateView() async {
    await _navigationService.navigateTo(CreatePostView.routName);
  }

  void editPost(int index) {
    _navigationService.navigateTo(EditPostView.routName,
        arguments: _post![index]);
  }
}
