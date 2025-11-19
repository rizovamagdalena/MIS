import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MealRecipesApp());
}

class MealRecipesApp extends StatelessWidget {
  const MealRecipesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Recipes',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}
