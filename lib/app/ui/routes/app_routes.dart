import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:prueba_tecnica_nolatech/app/domain/models/courts_mdl.dart';
import 'package:prueba_tecnica_nolatech/app/ui/pages/bookings/bookings_page.dart';
import 'package:prueba_tecnica_nolatech/app/ui/pages/favorites/favorites_page.dart';
import 'package:prueba_tecnica_nolatech/app/ui/pages/home/home_page.dart';
import 'package:prueba_tecnica_nolatech/app/ui/pages/login/login_page.dart';
import 'package:prueba_tecnica_nolatech/app/ui/pages/register/register_page.dart';
import 'package:prueba_tecnica_nolatech/app/ui/pages/reservation/reservation_page.dart';
import 'package:prueba_tecnica_nolatech/app/ui/pages/root/root_page.dart';

import '../global_controller/global_controller.dart';
import '../pages/bookings/controller/bookings_controller.dart';
import '../pages/favorites/controller/favorites_controller.dart';
import '../pages/home/controller/home_controller.dart';
import '../pages/login/controller/login_controller.dart';
import '../pages/register/controller/register_controller.dart';
import '../pages/reservation/controller/reservation_controller.dart';
import '../pages/root/controller/root_controller.dart';
import '../pages/splash/controller/splash_controller.dart';
import '../pages/splash/splash_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get getAppicationRoutes => {
        SplashPage.routerPage: (_) => const SplashPage(),
        LoginPage.routerPage: (_) => const LoginPage(),
        RegisterPage.routerPage: (_) => const RegisterPage(),
        RootPage.routerPage: (_) => const RootPage(),
        HomePage.routerPage: (_) => const HomePage(),
        ReservationPage.routerPage: (_) => const ReservationPage(),
        FavoritesPage.routerPage: (_) => const FavoritesPage(),
        BookingsPage.routerPage: (_) => const BookingsPage(),
      };

  static List<SingleChildWidget> get providers => [
        ChangeNotifierProvider(create: (_) => SplashController()),
        ChangeNotifierProvider(create: (_) => GlobalController()),
        ChangeNotifierProvider(create: (_) => RootController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => ReservationController()),
        ChangeNotifierProvider(create: (_) => FavoritesController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => RegisterController()),
        ChangeNotifierProvider(create: (_) => BookingsController())
      ];
}
