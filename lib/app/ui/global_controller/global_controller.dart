import 'package:flutter/material.dart';
import 'package:prueba_tecnica_nolatech/app/domain/models/user_mdl.dart';

import '../../domain/models/courts_mdl.dart';

class GlobalController extends ChangeNotifier {
  static GlobalController _instance = GlobalController._internal();

  factory GlobalController() {
    return _instance;
  }

  GlobalController._internal();

  static void reset() {
    _instance = GlobalController._internal();
  }

  final currentUser = User(
    id: 1,
    email: "abraham@test.com",
    name: "Abraham",
    password: "123456",
    phone: "77067950",
  );

  final courts = <Court>[
    Court(
      id: 1,
      name: "Epic Box",
      location: "Calle Estrella #200",
      type: "Tipo A",
      price: 25,
      available: true,
      initAvailable: "07:00",
      endAvailable: "18:00",
      percentRain: "37",
    ),
    Court(
      id: 2,
      name: "Rusty Tenis",
      location: "Calle Estrella #200",
      type: "Tipo B",
      price: 35,
      available: true,
      initAvailable: "09:00",
      endAvailable: "17:00",
      percentRain: "37",
    ),
    Court(
      id: 3,
      name: "Multipurpose Court",
      location: "Calle Estrella #200",
      type: "Tipo C",
      price: 45,
      available: true,
      initAvailable: "08:00",
      endAvailable: "20:00",
      percentRain: "37",
    ),
  ];
}
