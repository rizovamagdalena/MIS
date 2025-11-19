import 'package:flutter/material.dart';
import '../models/meal_detail.dart';
import '../services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = '/meal-detail';
  final String mealId;

  const MealDetailScreen({super.key, required this.mealId});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  MealDetail? meal;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMealDetail();
  }

  Future<void> fetchMealDetail() async {
    try {
      final data = await ApiService.getMealDetail(widget.mealId);
      setState(() {
        meal = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildIngredientList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: meal!.ingredients
          .map((ing) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Text('${ing.name} - ${ing.measure}'),
      ))
          .toList(),
    );
  }

  void _launchYoutube() async {
    if (meal!.youtubeLink.isNotEmpty) {
      final Uri url = Uri.parse(meal!.youtubeLink);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meal?.name ?? 'Meal Detail')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                meal!.thumbnail,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              meal!.name,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Ingredients:',
              style:
              TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            buildIngredientList(),
            const SizedBox(height: 12),
            const Text(
              'Instructions:',
              style:
              TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(meal!.instructions),
            const SizedBox(height: 12),
            if (meal!.youtubeLink.isNotEmpty)
              ElevatedButton.icon(
                onPressed: _launchYoutube,
                icon: const Icon(Icons.video_library),
                label: const Text('Watch on YouTube'),
              ),
          ],
        ),
      ),
    );
  }
}
