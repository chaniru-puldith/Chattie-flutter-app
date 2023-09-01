import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chattie/screens/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue.shade800,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue.shade800,
        scaffoldBackgroundColor: const Color(0xFF142432),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white54),
        ),
      ),
      themeMode: ThemeMode.system,
      home: WelcomeScreen(),
    );
  }
}
