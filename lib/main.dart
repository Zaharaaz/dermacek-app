import 'package:flutter/material.dart';
import 'screen/home/home.dart';
import 'screen/splash/splash.dart';
import 'screen/theme/theme.dart';
import 'util.dart';

void main() {
  runApp(const DermacekApp());
}

class DermacekApp extends StatelessWidget {
  const DermacekApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context, "Poppins", "Poppins");
    final theme = MaterialTheme(textTheme);
    
    return MaterialApp(
      title: 'Dermacek',
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}