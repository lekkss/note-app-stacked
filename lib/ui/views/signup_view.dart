import 'package:flutter/material.dart';
import 'package:note_app/ui/shared/ui_helpers.dart';
import 'package:note_app/ui/widgets/app_button.dart';
import 'package:stacked/stacked.dart';

import '../../locator.dart';
import '../../viewmodels/application_view_model.dart';
import '../shared/app_colors.dart';
import '../widgets/input.dart';

class SignupView extends StatefulWidget {
  static const routName = "/signup";
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppplicationViewModel>.reactive(
      viewModelBuilder: (() => locator<AppplicationViewModel>()),
      disposeViewModel: false,
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: const Text(
              "Signin",
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
                        verticalSpace(10),
                        Input(
                          textController: _passwordController,
                          hintText: "Password",
                          borderRadius: 25,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Password';
                            }
                            return null;
                          },
                        ),
                        verticalSpace(10),
                        Input(
                          textController: _lNameController,
                          hintText: "Last Name",
                          borderRadius: 25,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Last Name';
                            }
                            return null;
                          },
                        ),
                        verticalSpace(10),
                        Input(
                          textController: _fNameController,
                          hintText: "First Name",
                          borderRadius: 25,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter First Name';
                            }
                            return null;
                          },
                        ),
                        verticalSpaceLarge,
                        verticalSpace(40),
                        AppButton(
                            busy: model.isBusy,
                            title: "signup",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                debugPrint("Sign up screen");
                                model.register(
                                    _emailController.text,
                                    _passwordController.text,
                                    _fNameController.text,
                                    _lNameController.text);
                              } else {
                                debugPrint("not ok");
                              }
                            }),
                        verticalSpaceLarge,
                        const Text("Already have an account? "),
                        verticalSpaceMedium,
                        AppButton(
                            color: Colors.white,
                            titleColor: primaryColor,
                            title: "login",
                            onPressed: () {
                              model.to("login", replace: true);
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
