import 'package:flutter/material.dart';
import '../models/exam.dart';
import 'exam_card.dart';

class ExamList extends StatelessWidget {
  final List<Exam> exams;

  const ExamList({super.key, required this.exams});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: exams.length,
      itemBuilder: (context, index) {
        return ExamCard(exam: exams[index]);
      },
    );
  }
}
