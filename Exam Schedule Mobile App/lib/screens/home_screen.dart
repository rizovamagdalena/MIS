import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../widgets/exam_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Exam> exams = [
    Exam(subject: "Mathematics 3", dateTime: DateTime(2025, 11, 2, 9, 0), rooms: ["101", "102"]),
    Exam(subject: "Data Structures & Algorithms", dateTime: DateTime(2025, 11, 3, 11, 0), rooms: ["201"]),
    Exam(subject: "Databases", dateTime: DateTime(2025, 11, 4, 10, 30), rooms: ["103"]),
    Exam(subject: "Operating Systems", dateTime: DateTime(2025, 11, 5, 12, 0), rooms: ["104", "105"]),
    Exam(subject: "Computer Networks", dateTime: DateTime(2025, 11, 6, 9, 30), rooms: ["202"]),
    Exam(subject: "Software Quality & Testing", dateTime: DateTime(2025, 11, 7, 11, 0), rooms: ["203"]),
    Exam(subject: "Web Development", dateTime: DateTime(2025, 11, 8, 14, 0), rooms: ["301"]),
    Exam(subject: "Mobile App Development", dateTime: DateTime(2025, 11, 9, 15, 30), rooms: ["302"]),
    Exam(subject: "Artificial Intelligence", dateTime: DateTime(2025, 11, 10, 10, 0), rooms: ["303"]),
    Exam(subject: "Integrated Systems", dateTime: DateTime(2025, 11, 11, 8, 30), rooms: ["Gym"]),
  ];


  @override
  Widget build(BuildContext context) {
    exams.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam schedule for - 221042"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: exams.length,
              itemBuilder: (context, index) {
                return ExamCard(exam: exams[index]);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.blueGrey[50],
            child: Text(
              "Total number of exams: ${exams.length}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
