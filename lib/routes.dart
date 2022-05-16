import 'package:flutter/material.dart';
import 'package:note_app/ui/views/home.dart';
import 'package:note_app/ui/views/login_view.dart';
import 'package:note_app/ui/views/signup_view.dart';
import 'package:note_app/ui/views/splash.dart';

var appRoutes = <String, WidgetBuilder>{
  //intro
  '/': (ctx) => const SplashScreen(),

  //App routes
  LoginView.routName: (ctx) => const LoginView(),
  SignupView.routName: (ctx) => const SignupView(),
  // HomeView.routName: (ctx) => const HomeView(),
};
