import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../splash/controller/splash_controller.dart';

class WelcomePage extends StatelessWidget {
  static const routerPage = "/welcome";
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashController>(
      builder: (context, value, child) {
        value.onInit(context);
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.png"),
              ),
            ),
            child: Center(
              child: Image.asset("assets/logo.png"),
            ),
          ),
        );
      },
    );
  }
}
