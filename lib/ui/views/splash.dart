import 'package:flutter/material.dart';
import 'package:note_app/viewmodels/application_view_model.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppplicationViewModel>.reactive(
        viewModelBuilder: () => AppplicationViewModel(),
        onModelReady: (model) => model.handleSplashLogic(),
        disposeViewModel: false,
        builder: (context, model, child) {
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            )),
          );
        });
  }
}
