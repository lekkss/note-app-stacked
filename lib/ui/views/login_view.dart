import 'package:flutter/material.dart';
import 'package:note_app/ui/shared/app_colors.dart';
import 'package:note_app/ui/shared/ui_helpers.dart';
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

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppplicationViewModel>.reactive(
      viewModelBuilder: (() => locator<AppplicationViewModel>()),
      disposeViewModel: false,
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Hello"),
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
                        verticalSpaceLarge,
                        verticalSpaceLarge,
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              width: 3,
                              color: primaryColor,
                            ),
                            color: primaryColor,
                          ),
                          child: MaterialButton(
                              child: model.isBusy
                                  ? const CircularProgressIndicator(
                                      color: Colors.blue,
                                    )
                                  : const Text(
                                      "login",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  debugPrint("gone");

                                  model.login(_emailController.text,
                                      _passwordController.text);
                                }
                              }),
                        ),
                        // Container(
                        //   child: model.isBusy
                        //       ? const Text("getting")
                        //       : !model.isLoggedIn()
                        //           ? const Text("not usee")
                        //           : const Text("got"),
                        // ),
                        verticalSpaceLarge,
                        const Text("Already have an account? "),
                        verticalSpaceMedium,
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: MaterialButton(
                              child: const Text(
                                "signup",
                                style: TextStyle(
                                    fontSize: 16, color: primaryColor),
                              ),
                              onPressed: () {
                                model.to("signup", replace: true);
                              }),
                        ),
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
