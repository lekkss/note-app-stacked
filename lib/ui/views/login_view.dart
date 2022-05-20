import 'package:flutter/material.dart';
import 'package:note_app/ui/shared/app_colors.dart';
import 'package:note_app/ui/shared/ui_helpers.dart';
import 'package:note_app/ui/widgets/app_button.dart';
import 'package:note_app/ui/widgets/input.dart';
import 'package:note_app/viewmodels/application_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../locator.dart';

class LoginView extends StatefulWidget {
  static const routName = "/login";
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController(text: "test@test.com");
  final _passwordController = TextEditingController(text: "123lekan");
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppplicationViewModel>.reactive(
      viewModelBuilder: (() => locator<AppplicationViewModel>()),
      disposeViewModel: false,
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Login",
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 12,
                right: 12,
              ),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Input(
                          textController: _emailController,
                          hintText: "Email",
                          borderRadius: 25,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Email';
                            }
                            return null;
                          },
                        ),
                        verticalSpaceLarge,
                        Input(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Password';
                            }
                            return null;
                          },
                          borderRadius: 25,
                          hintText: "Password",
                          textController: _passwordController,
                        ),
                        verticalSpace(60),
                        AppButton(
                          busy: model.isBusy,
                          title: "login",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              model.login(_emailController.text,
                                  _passwordController.text);
                            }
                            debugPrint("worked");
                          },
                        ),
                        verticalSpaceLarge,
                        const Text("Don't have an account? "),
                        verticalSpaceMedium,
                        AppButton(
                            color: Colors.white,
                            titleColor: primaryColor,
                            title: "signup",
                            onPressed: () {
                              model.to("signup", replace: true);
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
