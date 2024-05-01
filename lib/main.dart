import 'package:flutter/material.dart';
import 'package:sos_community/screens/claims_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 11, 109, 60)),
        useMaterial3: true,
      ),
      home: const ClaimsListScreen(),
    );
  }
}
