import 'package:flutter_test/flutter_test.dart';
import 'package:alfabetizacao_tecnologica/models/quiz_question.dart';
import 'package:alfabetizacao_tecnologica/services/quiz_service.dart';

void main() {
  final service = QuizService();

  List<QuizQuestion> gerarBancoDeTeste(int quantidade) {
    return List.generate(
      quantidade,
      (i) => QuizQuestion(
        id: 'q$i',
        pergunta: 'Pergunta $i',
        opcoes: const ['A', 'B', 'C', 'D'],
        respostaCorreta: 0,
      ),
    );
  }

  group('QuizService.sortearPerguntas', () {
    test('retorna sempre 5 perguntas quando o banco tem 30', () {
      final banco = gerarBancoDeTeste(30);
      final sorteadas = service.sortearPerguntas(banco, quantidade: 5);
      expect(sorteadas.length, 5);
    });

    test('as perguntas sorteadas são únicas (sem repetição)', () {
      final banco = gerarBancoDeTeste(30);
      final sorteadas = service.sortearPerguntas(banco, quantidade: 5);
      final idsUnicos = sorteadas.map((q) => q.id).toSet();
      expect(idsUnicos.length, sorteadas.length);
    });

    test('não modifica a lista original do banco', () {
      final banco = gerarBancoDeTeste(30);
      final copiaOriginal = List<QuizQuestion>.from(banco);
      service.sortearPerguntas(banco, quantidade: 5);
      expect(banco.map((q) => q.id).toList(),
          copiaOriginal.map((q) => q.id).toList());
    });
  });

  group('QuizService.calcularPontuacao', () {
    test('calcula corretamente todos os acertos', () {
      final perguntas = gerarBancoDeTeste(5);
      final respostas = {for (final q in perguntas) q.id: 0};
      final pontuacao = service.calcularPontuacao(perguntas, respostas);
      expect(pontuacao, 5);
    });

    test('calcula corretamente quando há erros', () {
      final perguntas = gerarBancoDeTeste(5);
      final respostas = {
        for (final q in perguntas) q.id: 1, // todas erradas (correta é 0)
      };
      final pontuacao = service.calcularPontuacao(perguntas, respostas);
      expect(pontuacao, 0);
    });

    test('ignora perguntas sem resposta informada', () {
      final perguntas = gerarBancoDeTeste(3);
      final respostas = {perguntas[0].id: 0};
      final pontuacao = service.calcularPontuacao(perguntas, respostas);
      expect(pontuacao, 1);
    });
  });
}
