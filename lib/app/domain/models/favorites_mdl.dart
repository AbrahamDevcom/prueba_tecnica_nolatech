import 'package:hive/hive.dart';

part 'favorites_mdl.g.dart';

@HiveType(typeId: 1)
class Favorites {
  @HiveField(1)
  int userId;
  @HiveField(2)
  int courtId;

  Favorites({
    required this.userId,
    required this.courtId,
  });
  factory Favorites.empty() {
    return Favorites(userId: -1, courtId: -1);
  }

  factory Favorites.fromMap(Map<String, dynamic> json) => Favorites(
        userId: json["user_id"],
        courtId: json["court_id"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "court_id": courtId,
      };
}
