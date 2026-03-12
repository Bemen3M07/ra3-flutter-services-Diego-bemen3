import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coches Api',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 240, 132, 59)),
      ),
      home: const HomePage(title: 'Coches api '),
    );
  }
}

