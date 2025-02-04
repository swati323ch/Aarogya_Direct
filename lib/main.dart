import 'package:arogya_direct/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:arogya_direct/Screens/map.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Arogya());
}

class Arogya extends StatelessWidget {
  const Arogya({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Welcome(),
        '/map': (context) => const MapScreen(),
      },
      title: "ArogyaDirect",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(),
          shadowColor: Color.fromARGB(190, 11, 66, 216),
        ),
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}
