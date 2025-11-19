import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';
import '../models/meal_detail.dart';

class ApiService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  // Fetch all categories
  static Future<List<Category>> getCategories() async {
    final url = Uri.parse('$baseUrl/categories.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final categories = (data['categories'] as List)
          .map((json) => Category.fromJson(json))
          .toList();
      return categories;
    } else {
      throw Exception('Failed to load categories!');
    }
  }

  // Fetch meals by category
  static Future<List<Meal>> getMealsByCategory(String category) async {
    final url = Uri.parse('$baseUrl/filter.php?c=$category');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final meals = (data['meals'] as List)
          .map((json) => Meal.fromJson(json))
          .toList();
      return meals;
    } else {
      throw Exception('Failed to load meals for category $category!');
    }
  }

  // Search meals by name
  static Future<List<Meal>> searchMeals(String query) async {
    final url = Uri.parse('$baseUrl/search.php?s=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['meals'] == null) return [];
      final meals = (data['meals'] as List)
          .map((json) => Meal.fromJson(json))
          .toList();
      return meals;
    } else {
      throw Exception('Failed to search meals!');
    }
  }

  // Fetch meal details by ID
  static Future<MealDetail> getMealDetail(String id) async {
    final url = Uri.parse('$baseUrl/lookup.php?i=$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return MealDetail.fromJson(data['meals'][0]);
    } else {
      throw Exception('Failed to load meal details!');
    }
  }

  // Fetch a random meal
  static Future<MealDetail> getRandomMeal() async {
    final url = Uri.parse('$baseUrl/random.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return MealDetail.fromJson(data['meals'][0]);
    } else {
      throw Exception('Failed to load random meal!');
    }
  }
}