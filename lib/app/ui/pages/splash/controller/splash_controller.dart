import 'package:flutter/material.dart';
import '../../root/root_page.dart';

class SplashController extends ChangeNotifier {
  void onInit(BuildContext context) {
    Future.delayed(Durations.extralong4, () {
      Navigator.pushReplacementNamed(context, RootPage.routerPage);
    });
  }
}
