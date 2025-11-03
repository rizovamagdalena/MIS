import 'package:flutter/material.dart';
import '../models/exam.dart';

class ExamDetailsScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailsScreen({super.key, required this.exam});

  String getRemainingTime() {
    final now = DateTime.now();
    final difference = exam.dateTime.difference(now);

    if (difference.isNegative) {
      return "Exam has passed!";
    }

    final days = difference.inDays;
    final hours = difference.inHours % 24;

    return "$days day(s), $hours hour(s)";
  }

  @override
  Widget build(BuildContext context) {
    bool isPast = exam.dateTime.isBefore(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(exam.subject),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: 8),
                Text("${exam.dateTime.day}/${exam.dateTime.month}/${exam.dateTime.year}"),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time),
                const SizedBox(width: 8),
                Text("${exam.dateTime.hour}:${exam.dateTime.minute.toString().padLeft(2, '0')}"),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 8),
                Text(exam.rooms.join(", ")),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.timer),
                const SizedBox(width: 8),
                Text(getRemainingTime(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isPast ? Colors.red : Colors.green)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
