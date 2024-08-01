import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:prueba_tecnica_nolatech/app/data/remote/weather_api.dart';
import 'package:prueba_tecnica_nolatech/app/domain/models/favorites_mdl.dart';
import 'package:prueba_tecnica_nolatech/app/ui/global_controller/global_controller.dart';
import '../../../../domain/models/reservation_mdl.dart';

class ReservationController extends ChangeNotifier {
  // ReservationController() {
  //   final now = DateTime.now();
  //   final formattedDate = DateFormat('yyyy/MM/dd').format(now);
  //   checkWeather(formattedDate, latitudeHome, longitudeHome);
  //   notifyListeners();
  // }
  @override
  void dispose() {
    // Limpiar recursos
    textDateController.clear();
    commentController.clear();
    hoursInit = [];
    hoursEnd = [];
    super.dispose();
  }

  final listInstructors = ["Ninguno", "Alejandro Mendez", "Carlos Estrada"];
  List hoursInit = [];
  List hoursEnd = [];
  String initSelected = "";
  String endSelected = "";
  int bookingDuration = 0;
  final formKey = GlobalKey<FormState>();
  TextEditingController textDateController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  DateTime dateController = DateTime.now();
  dynamic rainValue;
  String instructorSelected = "";

  set textValue(value) {
    textDateController.text = value;
  }

  set dateSelected(value) {
    dateController = value;
  }

  set rainPercentage(value) {
    rainValue = value;
  }

  void getRainPercentage(date, lat, lng) async {
    rainPercentage = await WeatherApi.getRainPercentage(date, lat, lng);
  }

  void checkWeather(String date, double latitude, double longitude) async {
    rainPercentage =
        await WeatherApi.getTodayRainPercentage(date, latitude, longitude);
  }

  void generateStartTime(String startTime, String closingTime) {
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(now);
    DateTime start = DateTime.parse('${formattedDate}T$startTime:00Z');
    DateTime close = DateTime.parse('${formattedDate}T$closingTime:00Z');
    close = close.subtract(const Duration(hours: 1));

    List<String> horasDisponibles = [];

    while (start.isBefore(close) || start.isAtSameMomentAs(close)) {
      horasDisponibles.add(start.toIso8601String().substring(11, 16));
      start = start.add(const Duration(hours: 1));
    }

    hoursInit = horasDisponibles;
  }

  void generateEndTime(String startTime, String closingTime) {
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(now);
    DateTime start = DateTime.parse('${formattedDate}T$startTime:00Z');
    DateTime close = DateTime.parse('${formattedDate}T$closingTime:00Z');

    start = start.add(const Duration(hours: 1));

    List<String> horasDeFinalizacion = [];

    while (start.isBefore(close) || start.isAtSameMomentAs(close)) {
      horasDeFinalizacion.add(start.toIso8601String().substring(11, 16));
      start = start.add(const Duration(hours: 1));
    }

    hoursEnd = horasDeFinalizacion;
  }

  void calculateDuration(String startTime, String closingTime) {
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(now);
    DateTime start = DateTime.parse('${formattedDate}T$startTime:00Z');
    DateTime close = DateTime.parse('${formattedDate}T$closingTime:00Z');

    Duration duracion = close.difference(start);

    bookingDuration = duracion.inHours;
  }

  void saveReservation({
    required int userId,
    required String date,
    required String timeInit,
    required String timeFinal,
    required int duration,
    required String instructor,
    required int courtId,
    required String courtType,
    required dynamic chanceOfRain,
    required String comment,
  }) async {
    var reservationBox = Hive.box<Reservation>('reservation');
    final id = reservationBox.values.length;
    var reservation = Reservation(
      id: id,
      userId: userId,
      date: date,
      timeInit: timeInit,
      timeFinal: timeFinal,
      duration: duration,
      instructor: instructor,
      courtId: courtId,
      courtType: courtType,
      chanceOfRain: chanceOfRain,
      comment: comment,
    );
    await reservationBox.add(reservation);
  }

  void toggleFavorite(int courtId) async {
    print("tp");
    var favoritesBox = Hive.box<Favorites>('favorites');
    var existingFavorite = favoritesBox.values.firstWhere(
      (favorite) =>
          favorite.userId == GlobalController().currentUser.id &&
          favorite.courtId == courtId,
      orElse: () => Favorites.empty(),
    );
    print(existingFavorite.userId);
    if (existingFavorite.userId != -1) {
      await favoritesBox.delete(existingFavorite);
      notifyListeners();
    } else {
      var favorite = Favorites(
          userId: GlobalController().currentUser.id, courtId: courtId);
      await favoritesBox.add(favorite);
      notifyListeners();
    }
  }

  bool isFavorite(int courtId) {
    var favoritesBox = Hive.box<Favorites>('favorites');
    var existingFavorite = favoritesBox.values.firstWhere(
      (favorite) =>
          favorite.userId == GlobalController().currentUser.id &&
          favorite.courtId == courtId,
      orElse: () => Favorites.empty(),
    );
    print(existingFavorite.userId);
    return existingFavorite.userId != -1;
  }
}
