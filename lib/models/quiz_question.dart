class QuizQuestion {
  final String id;
  final String pergunta;
  final List<String> opcoes;
  final int respostaCorreta;

  QuizQuestion({
    required this.id,
    required this.pergunta,
    required this.opcoes,
    required this.respostaCorreta,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) => QuizQuestion(
        id: json['id'] as String,
        pergunta: json['pergunta'] as String,
        opcoes: List<String>.from(json['opcoes'] as List),
        respostaCorreta: json['resposta_correta'] as int,
      );
}
