import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prueba_tecnica_nolatech/app/ui/global_controller/global_controller.dart';

import '../../../../domain/models/reservation_mdl.dart';

class BookingsController extends ChangeNotifier {
  BookingsController() {
    getReservations();
  }
  List<Reservation> reservations = [];
  set setReservations(List<Reservation> value) {
    reservations = value;
    notifyListeners();
  }

  Future<List<Reservation>> getReservations() async {
    final reservationBox = Hive.box<Reservation>('reservation');
    print(reservationBox.values.length);
    var userReservations = reservationBox.values
        .where((reservation) =>
            reservation.userId == GlobalController().currentUser.id)
        .toList();
    return userReservations;
  }
}
