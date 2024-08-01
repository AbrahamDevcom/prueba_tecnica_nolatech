import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:prueba_tecnica_nolatech/app/utils/constants.dart';

import '../../../../data/remote/weather_api.dart';
import '../../../../domain/models/reservation_mdl.dart';
import '../../../global_controller/global_controller.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy/MM/dd').format(now);
    checkWeatherAndReserve(formattedDate, latitudeHome, longitudeHome);
  }
  int? _rainPercentage;
  int? get rainPercentage => _rainPercentage;
  set rainPercentage(int? value) {
    _rainPercentage = value;
    notifyListeners();
  }

  void checkWeatherAndReserve(
    String date,
    double latitude,
    double longitude,
  ) async {
    print(date);
    rainPercentage = await WeatherApi.getTodayRainPercentage(
      date,
      latitude,
      longitude,
    );
  }

  Future<List<Reservation>> getReservations() async {
    final reservationBox = Hive.box<Reservation>('reservation');
    print(reservationBox.values.length);
    var userReservations = reservationBox.values
        .where((reservation) =>
            reservation.userId == GlobalController().currentUser.id)
        .toList();
    userReservations.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return userReservations;
  }
}
