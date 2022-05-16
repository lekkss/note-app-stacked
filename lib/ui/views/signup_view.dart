import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../locator.dart';
import '../../viewmodels/application_view_model.dart';
import '../widgets/app_text.dart';

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
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter something';
                          }
                          return null;
                        },
                        controller: _lNameController,
                        decoration: const InputDecoration(
                          hintText: "Last Name",
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter something';
                          }
                          return null;
                        },
                        controller: _fNameController,
                        decoration: const InputDecoration(
                          hintText: "First NAme",
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
                            child: AppText.headingThree(
                              "Signup",
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                debugPrint("Sign up screen");
                                model.register(
                                    _emailController.text,
                                    _passwordController.text,
                                    _fNameController.text,
                                    _lNameController.text);
                                model.to("login");
                              } else {
                                debugPrint("not ok");
                              }
                            }),
                      ),
                      Container(
                        child: model.isBusy
                            ? const Text("getting")
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
                              "Login",
                            ),
                            onPressed: () {
                              model.to("login", replace: true);
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
