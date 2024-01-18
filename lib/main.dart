import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/presentation/index.dart';
import 'package:task_management_app/providers/task_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Management App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const DefaultTabController(length: 3, child: HomePage()),
      ),
    );
  }
}
