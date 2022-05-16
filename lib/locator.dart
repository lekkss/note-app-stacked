import 'package:get_it/get_it.dart';
import 'package:note_app/services/cloud_storage_service.dart';
import 'package:note_app/services/firestore_service.dart';
import 'package:note_app/viewmodels/application_view_model.dart';
import 'package:note_app/viewmodels/create_post_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart' as ss;
import 'package:note_app/services/navigation_services.dart';

import 'services/dialog_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => ss.NavigationService());
  locator.registerLazySingleton(() => MyNavigationServices());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => FireStoreService());
  locator.registerLazySingleton(() => AppplicationViewModel());
  // locator.registerLazySingleton(() => CreatePostViewModel());
}
