import 'dart:math';

import '../models/quiz_question.dart';

class QuizService {
  final Random _random = Random();

  List<QuizQuestion> sortearPerguntas(
    List<QuizQuestion> banco, {
    int quantidade = 5,
  }) {
    final copia = List<QuizQuestion>.from(banco)..shuffle(_random);
    return copia.take(quantidade).toList();
  }

  int calcularPontuacao(
    List<QuizQuestion> perguntas,
    Map<String, int> respostasUsuario,
  ) {
    int acertos = 0;
    for (final q in perguntas) {
      if (respostasUsuario[q.id] == q.respostaCorreta) {
        acertos++;
      }
    }
    return acertos;
  }
}
