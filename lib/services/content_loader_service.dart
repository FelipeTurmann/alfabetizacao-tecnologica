import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../models/tutorial.dart';
import '../models/security_tip.dart';
import '../models/quiz_question.dart';


class ContentLoaderService {
  Future<List<Tutorial>> loadTutorials() async {
    final data = await rootBundle.loadString('assets/data/tutorials.json');
    final list = json.decode(data) as List;
    return list
        .map((e) => Tutorial.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<SecurityTip>> loadSecurityTips() async {
    final data =
        await rootBundle.loadString('assets/data/security_tips.json');
    final list = json.decode(data) as List;
    return list
        .map((e) => SecurityTip.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<QuizQuestion>> loadQuizQuestions() async {
    final data =
        await rootBundle.loadString('assets/data/quiz_questions.json');
    final list = json.decode(data) as List;
    return list
        .map((e) => QuizQuestion.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
