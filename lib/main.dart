import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_generator/config/theme/app_theme.dart';
import 'package:password_generator/pages/home.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PassGen',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().theme(),
        home: const Home());
  }
}
