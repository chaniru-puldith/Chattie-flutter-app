import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chattie/screens/welcome_screen.dart';
import 'package:chattie/screens/login_screen.dart';
import 'package:chattie/screens/registration_screen.dart';
import 'package:chattie/screens/chat_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black54,
              displayColor: Colors.black54,
            ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue.shade800,
        scaffoldBackgroundColor: const Color(0xFF142432),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white54,
              displayColor: Colors.white54,
            ),
      ),
      themeMode: ThemeMode.system,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
      },
    );
  }
}
