import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../screens/exam_details_screen.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    bool isPast = exam.dateTime.isBefore(DateTime.now());

    return Card(
      color: isPast ? Colors.grey[300] : Colors.green[100],
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        leading: const Icon(Icons.book),
        title: Text(exam.subject, style: const TextStyle(fontSize: 18)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 4),
                Text("${exam.dateTime.day}/${exam.dateTime.month}/${exam.dateTime.year}"),
                const SizedBox(width: 10),
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 4),
                Text("${exam.dateTime.hour}:${exam.dateTime.minute.toString().padLeft(2, '0')}"),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 4),
                Text(exam.rooms.join(", ")),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExamDetailsScreen(exam: exam),
            ),
          );
        },
      ),
    );
  }
}
