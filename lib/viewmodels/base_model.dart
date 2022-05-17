import 'package:note_app/locator.dart';
import 'package:note_app/viewmodels/application_view_model.dart';
import 'package:stacked/stacked.dart';

class BaseModel extends BaseViewModel {
  final AppplicationViewModel _appplicationViewModel =
      locator<AppplicationViewModel>();

  get currentUser => _appplicationViewModel.currentUser;
  get isLogged => _appplicationViewModel.isLoggedIn();
  get logOut => _appplicationViewModel.logout();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
