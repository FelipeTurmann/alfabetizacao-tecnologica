import 'package:flutter/material.dart';

import '../models/quiz_question.dart';
import '../services/content_loader_service.dart';
import '../services/quiz_service.dart';

enum QuizStatus { carregando, emAndamento, finalizado, erro }


class QuizProvider extends ChangeNotifier {
  final ContentLoaderService _contentLoader;
  final QuizService _quizService;

  QuizProvider({
    ContentLoaderService? contentLoader,
    QuizService? quizService,
  })  : _contentLoader = contentLoader ?? ContentLoaderService(),
        _quizService = quizService ?? QuizService();

  QuizStatus status = QuizStatus.carregando;
  List<QuizQuestion> _perguntasSorteadas = [];
  final Map<String, int> _respostas = {};
  int indiceAtual = 0;

  List<QuizQuestion> get perguntas => _perguntasSorteadas;
  int get totalPerguntas => _perguntasSorteadas.length;
  QuizQuestion? get perguntaAtual =>
      indiceAtual < _perguntasSorteadas.length
          ? _perguntasSorteadas[indiceAtual]
          : null;

  int? get respostaSelecionadaAtual =>
      perguntaAtual != null ? _respostas[perguntaAtual!.id] : null;

  bool get isUltimaPergunta =>
      indiceAtual == _perguntasSorteadas.length - 1;

  Future<void> iniciarNovoQuiz() async {
    status = QuizStatus.carregando;
    indiceAtual = 0;
    _respostas.clear();
    notifyListeners();

    try {
      final banco = await _contentLoader.loadQuizQuestions();
      _perguntasSorteadas = _quizService.sortearPerguntas(banco, quantidade: 5);
      status = QuizStatus.emAndamento;
    } catch (_) {
      status = QuizStatus.erro;
    }
    notifyListeners();
  }

  void selecionarResposta(int indiceOpcao) {
    final pergunta = perguntaAtual;
    if (pergunta == null) return;
    _respostas[pergunta.id] = indiceOpcao;
    notifyListeners();
  }

  void avancar() {
    if (isUltimaPergunta) {
      status = QuizStatus.finalizado;
    } else {
      indiceAtual++;
    }
    notifyListeners();
  }

  int get pontuacaoFinal =>
      _quizService.calcularPontuacao(_perguntasSorteadas, _respostas);
}
