import 'package:flutter/material.dart';
import 'package:todo_list_isar_database/pages/home_page.dart';
import 'package:todo_list_isar_database/services/database_service.dart';

void main() async {
  await _setup();
  runApp(const MyApp());
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.setup();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage());
  }
}
