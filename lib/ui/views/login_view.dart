import 'package:flutter/material.dart';
import 'package:note_app/ui/widgets/app_text.dart';
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
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter something';
                          }
                          return null;
                        },
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: "Email",
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter something';
                          }
                          return null;
                        },
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          hintText: "Password",
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: MaterialButton(
                            child: model.isBusy
                                ? const CircularProgressIndicator(
                                    color: Colors.blue,
                                  )
                                : AppText.headingThree(
                                    "Login",
                                  ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                debugPrint("gone");

                                model.login(_emailController.text,
                                    _passwordController.text);
                              }
                            }),
                      ),
                      Container(
                        child: model.isBusy
                            ? const Text("getting")
                            : !model.isLoggedIn()
                                ? const Text("not usee")
                                : const Text("got"),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: MaterialButton(
                            child: AppText.headingThree(
                              "Signup",
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
        );
      },
    );
  }
}
