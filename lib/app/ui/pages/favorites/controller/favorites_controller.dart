import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prueba_tecnica_nolatech/app/domain/models/favorites_mdl.dart';

import '../../../global_controller/global_controller.dart';

class FavoritesController extends ChangeNotifier {
  Future<List<Favorites>> getReservations() async {
    final reservationBox = Hive.box<Favorites>('favorites');
    print(reservationBox.values.length);
    var userReservations = reservationBox.values
        .where((reservation) =>
            reservation.userId == GlobalController().currentUser.id)
        .toList();
    return userReservations;
  }
}
