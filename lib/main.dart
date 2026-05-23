import 'package:flutter/material.dart';
import 'package:thiskrit_space/app/spaces/spaces_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Thiskrit Spaces', home: ThiskritSpacesScreen());
  }
}
