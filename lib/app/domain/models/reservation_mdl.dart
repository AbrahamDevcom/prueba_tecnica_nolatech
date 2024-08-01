import 'package:hive/hive.dart';

part 'reservation_mdl.g.dart';

@HiveType(typeId: 1)
class Reservation {
  @HiveField(1)
  int id;
  @HiveField(2)
  int userId;
  @HiveField(3)
  String date;
  @HiveField(4)
  String timeInit;
  @HiveField(5)
  String timeFinal;
  @HiveField(6)
  int duration;
  @HiveField(7)
  dynamic instructor;
  @HiveField(8)
  int courtId;
  @HiveField(9)
  String courtType;
  @HiveField(10)
  dynamic chanceOfRain;
  @HiveField(11)
  String comment;

  Reservation({
    required this.id,
    required this.userId,
    required this.date,
    required this.timeInit,
    required this.timeFinal,
    required this.duration,
    required this.instructor,
    required this.courtId,
    required this.courtType,
    required this.chanceOfRain,
    required this.comment,
  });

  factory Reservation.fromMap(Map<String, dynamic> json) => Reservation(
        id: json["id"],
        userId: json["user_id"],
        date: json["date"],
        timeInit: json["time_init"],
        timeFinal: json["time_final"],
        duration: json["duration"],
        instructor: json["instructor"],
        courtId: json["court_id"],
        courtType: json["court_type"],
        chanceOfRain: json["chance_of_rain"],
        comment: json["comment"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "date": date,
        "time_init": timeInit,
        "time_final": timeFinal,
        "duration": duration,
        "instructor": instructor,
        "court_id": courtId,
        "court_type": courtType,
        "chance_of_rain": chanceOfRain,
        "comment": comment,
      };

  DateTime get dateTime => DateTime.parse(date);
}
