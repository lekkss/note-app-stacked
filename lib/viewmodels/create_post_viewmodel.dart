// import 'package:note_app/models/post.dart';
// import 'package:note_app/viewmodels/base_model.dart';

// import '../locator.dart';
// import '../services/dialog_service.dart';
// import '../services/firestore_service.dart';
// import '../services/navigation_services.dart';

// class CreatePostViewModel extends BaseModel {
//   final FireStoreService _fireStoreService = locator<FireStoreService>();
//   final DialogService _dialogService = locator<DialogService>();
//   final MyNavigationServices _navigationService =
//       locator<MyNavigationServices>();

//   Post? _edittingPost;
//   bool get _editing => _edittingPost != null;
//   Future addPost(String title, String message) async {
//     final result;

//     setBusy(true);
//     if (!_editing) {
//       result = await _fireStoreService.addPost(Post(
//         userId: currentUser!.userId,
//         message: message,
//         title: title,
//       ));
//     } else {
//       result = await _fireStoreService.updatePost(Post(
//         userId: _edittingPost!.userId,
//         message: message,
//         title: title,
//       ));
//     }
//     setBusy(false);
//     if (result is String) {
//       await _dialogService.showDialog(
//         title: 'Cound not create post',
//         description: result,
//       );
//     } else {
//       await _dialogService.showDialog(
//         title: 'Post successfully Added',
//         description: 'Your post has been created',
//       );
//     }

//     _navigationService.pop();
//   }

//   void setEdittingPost(Post edittingPost) {
//     _edittingPost = edittingPost;
//   }
// }
