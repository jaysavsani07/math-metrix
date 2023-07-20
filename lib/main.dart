import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get_it/get_it.dart';
import 'package:mathgame/src/ui/app/app.dart';
import 'package:mathgame/src/ui/app/theme_provider.dart';
import 'package:mathgame/src/ui/dashboard/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Uncomment the following lines when enabling Firebase Crashlytics
// import 'package:firebase_core/firebase_core.dart';
// import 'package:mathgame/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode) {
    Animate.restartOnHotReload = true;
  }

  FirebaseAnalytics? firebaseAnalytics;
  FirebaseCrashlytics? crashlytics;

  // To enable Firebase Crashlytics and Analytics, uncomment the following lines and
  // the import statements at the top of this file.
  // See the 'Crashlytics and Analytics' section of the main README.md file for details.

  // try {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  //   firebaseAnalytics = FirebaseAnalytics.instance;
  //   crashlytics = FirebaseCrashlytics.instance;
  // } catch (e) {
  //   debugPrint("Firebase couldn't be initialized: $e");
  // }

  if (kDebugMode) {
    await crashlytics?.setCrashlyticsCollectionEnabled(false);
    await firebaseAnalytics?.setAnalyticsCollectionEnabled(false);
  }

  if (crashlytics != null) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  final sharedPreferences = await SharedPreferences.getInstance();

  setupServiceLocator(sharedPreferences);
  runApp(
    MultiProvider(
      providers: [
        // Provider<SharedPreferences>(create: (context) => sharedPreferences),
        ChangeNotifierProvider(
          create: (context) =>
              ThemeProvider(sharedPreferences: sharedPreferences),
        ),
        ChangeNotifierProvider<DashboardProvider>(
          create: (context) => GetIt.I.get<DashboardProvider>(),
        )
      ],
      child: MyApp(
        firebaseAnalytics: firebaseAnalytics,
      ),
    ),
  );
}

setupServiceLocator(SharedPreferences sharedPreferences) {
  GetIt.I.registerSingleton<DashboardProvider>(
      DashboardProvider(preferences: sharedPreferences));
}
