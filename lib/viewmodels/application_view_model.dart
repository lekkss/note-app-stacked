import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:note_app/locator.dart';
import 'package:note_app/models/user.dart';
import 'package:note_app/services/navigation_services.dart';
import 'package:note_app/ui/views/create_post.dart';
import 'package:note_app/ui/views/login_view.dart';
import 'package:note_app/ui/views/home.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/firestore_service.dart';
import '../ui/views/signup_view.dart';

class AppplicationViewModel extends BaseViewModel {
  final MyNavigationServices _navService = locator<MyNavigationServices>();
  final FireStoreService _fireStoreService = locator<FireStoreService>();
  final DialogService _dialogService = locator<DialogService>();
  Users? _currentUser;
  Users? get currentUser => _currentUser;
  final auth = FirebaseAuth.instance;
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  String? email() {
    return auth.currentUser?.email;
  }

  Future register(
      String email, String password, String firstName, String lastName) async {
    try {
      final authResult = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _currentUser = Users(
          id: authResult.user!.uid,
          email: email,
          firstName: firstName,
          lastName: lastName);

      await _fireStoreService.createUser(_currentUser!);
      to("post", replace: true);
      notifyListeners();
      return authResult.user != null;
    } on FirebaseException catch (e) {
      debugPrint("Failed with error code: ${e.code}");
    }
  }

  Future login(
    String email,
    String password,
  ) async {
    try {
      setBusy(true);
      final authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      await _populateCurrentUser(authResult.user!);
      setBusy(false);

      to("post", replace: true);

      notifyListeners();
      return authResult != null;
    } on FirebaseAuthException catch (e) {
      setBusy(false);

      _dialogService.showDialog(
        title: 'Login Failure',
        description: e.code,
      );
      debugPrint('Error: Failed with error code: ${e.code}');
    }
  }

  void logout() async {
    await auth.signOut();
    debugPrint("user successfully out");
    to("login", replace: true);
    notifyListeners();
  }

  Future handleSplashLogic() async {
    Future.delayed(const Duration(seconds: 3), () async {
      if (!isLoggedIn()) {
        to("home", replace: true);
      }
      to("login", replace: true);
      notifyListeners();
    });
  }

  void to(String route, {bool replace = false}) {
    String? toRoute;

    switch (route) {
      case "post":
        toRoute = PostHomeView.routName;
        break;
      case "home":
        toRoute = HomeView.routName;
        break;
      case "login":
        toRoute = LoginView.routName;
        break;
      case "signup":
        toRoute = SignupView.routName;
        break;
    }
    if (toRoute!.isNotEmpty) {
      _navService.navigateTo(toRoute, replace: replace);
    }
  }

  Future _populateCurrentUser(User user) async {
    if (user != null) {
      _currentUser = await _fireStoreService.getUser(user.uid);
    }
  }
}
