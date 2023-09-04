import 'package:flutter/material.dart';
import 'package:helium_chat_application/feature/startup/presentation/screen/startup_screen.dart';
import 'package:helium_chat_application/shared_services/locator.dart';
import 'package:helium_chat_application/shared_services/navigation_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: locator<NavigationService>().navigationKey,
      title: 'Helium Health Chat Application',
      home: const StartupScreen(),
    );
  }
}
