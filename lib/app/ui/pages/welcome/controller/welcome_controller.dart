import 'package:flutter/material.dart';

import '../../login/login_page.dart';
import '../../register/register_page.dart';

class WelcomeController extends ChangeNotifier {
  void loginNavigate(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginPage.routerPage);
  }

  void registerNavigate(BuildContext context) {
    Navigator.pushReplacementNamed(context, RegisterPage.routerPage);
  }
}
