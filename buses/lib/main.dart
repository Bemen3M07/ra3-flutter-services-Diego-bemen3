import 'package:flutter/material.dart';
import 'page/search_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buses por Parada',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SearchPage(),
    );
  }
}
