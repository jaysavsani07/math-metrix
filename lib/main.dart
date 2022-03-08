import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/ui/app/app.dart';
import 'package:mathgame/src/ui/app/theme_provider.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  setupServiceLocator(sharedPreferences);
  runApp(MultiProvider(providers: [
    // Provider<SharedPreferences>(create: (context) => sharedPreferences),
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(sharedPreferences: sharedPreferences),
    ),
    ChangeNotifierProvider<DashboardProvider>(
      create: (context) => GetIt.I.get<DashboardProvider>(),
    )
  ], child: MyApp()));
}

setupServiceLocator(SharedPreferences sharedPreferences) {
  GetIt.I.registerSingleton<DashboardProvider>(DashboardProvider(preferences: sharedPreferences));
}
