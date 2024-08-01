import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'app/domain/models/favorites_mdl.dart';
import 'app/domain/models/reservation_mdl.dart';
import 'app/domain/models/user_mdl.dart';
import 'app/my_app.dart';
import 'app/ui/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ReservationAdapter());
  Hive.registerAdapter(FavoritesAdapter());
  await Hive.openBox<User>('users');
  await Hive.openBox<Reservation>('reservation');
  await Hive.openBox<Favorites>('favorites');
  runApp(
    MultiProvider(
      providers: AppRoutes.providers,
      child: const MyApp(),
    ),
  );
}
