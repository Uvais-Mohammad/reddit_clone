import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/locale/localization.dart';
import 'package:reddit_clone/core/routes/routes.dart';
import 'package:reddit_clone/firebase_options.dart';
import 'package:reddit_clone/theme/pallette.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: LocalizationStrings.appName,
      theme: Pallette.darkModeAppTheme,
      routerDelegate:
          RoutemasterDelegate(routesBuilder: (context) => loggedOutRoutes),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
