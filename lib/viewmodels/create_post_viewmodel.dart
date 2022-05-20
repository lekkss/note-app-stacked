import 'package:note_app/models/post.dart';
import 'package:note_app/viewmodels/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

import '../locator.dart';
import '../services/firestore_service.dart';
import '../services/navigation_services.dart';

class CreatePostViewModel extends BaseModel {
  final FireStoreService _fireStoreService = locator<FireStoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final MyNavigationServices _navigationService =
      locator<MyNavigationServices>();

  Post? _edittingPost;
  bool get _editting => _edittingPost != null;
  Future addPost(String title, String message) async {
    dynamic result;

    setBusy(true);
    if (!_editting) {
      result = await _fireStoreService.addPost(Post(
        userId: currentUser!.id,
        message: message,
        title: title,
      ));
    } else {
      result = await _fireStoreService.updatePost(Post(
        userId: _edittingPost!.userId,
        message: message,
        title: title,
      ));
    }
    setBusy(false);
    if (result is String) {
      await _dialogService.showDialog(
        title: 'Cound not create post',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Post successfully Added',
        description: 'Your post has been created',
      );
    }

    _navigationService.pop();
  }

  void setEdittingPost(Post edittingPost) {
    _edittingPost = edittingPost;
  }
}
