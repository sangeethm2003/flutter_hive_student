import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/student_model.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Hive.initFlutter();

  
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(StudentModelAdapter());
  }

  await Hive.openBox<StudentModel>('studentBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
