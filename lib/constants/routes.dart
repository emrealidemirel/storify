import 'package:flutter/widgets.dart';
import 'package:storify/pages/home_page.dart';
import 'package:storify/pages/reset_password_page.dart';
import 'package:storify/pages/sign_in_page.dart';
import 'package:storify/pages/sign_up_page.dart';
import 'package:storify/pages/settings_page.dart';
import 'package:storify/widgets/auth_guard.dart';

class Routes {
  static const String language = "/language";
  static const String home = "/home";
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
  static const String passwordReset = "/passwordReset";
  static const String settings = "/settings";

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => AuthGuard(child: HomePage()),
      signIn: (context) => const SignInPage(),
      signUp: (context) => const SignUpPage(),
      passwordReset: (context) => const ResetPasswordPage(),
      settings: (context) => const AuthGuard(child: SettingsPage()),
    };
  }
}
