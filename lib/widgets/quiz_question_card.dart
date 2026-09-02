import 'package:flutter/material.dart';

import '../models/quiz_question.dart';


class QuizQuestionCard extends StatelessWidget {
  final QuizQuestion pergunta;
  final int numero;
  final int total;
  final int? respostaSelecionada;
  final ValueChanged<int> onSelecionar;

  const QuizQuestionCard({
    super.key,
    required this.pergunta,
    required this.numero,
    required this.total,
    required this.respostaSelecionada,
    required this.onSelecionar,
  });

  @override
  Widget build(BuildContext context) {
    final corPrimaria = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pergunta $numero de $total',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: corPrimaria,
              ),
        ),
        const SizedBox(height: 12),
        Text(
          pergunta.pergunta,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ...List.generate(pergunta.opcoes.length, (indice) {
          final selecionada = respostaSelecionada == indice;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Semantics(
              button: true,
              selected: selecionada,
              label: pergunta.opcoes[indice],
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => onSelecionar(indice),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      vertical: 18, horizontal: 20),
                  decoration: BoxDecoration(
                    color: selecionada
                        ? corPrimaria.withOpacity(0.15)
                        : Theme.of(context).cardColor,
                    border: Border.all(
                      color: selecionada
                          ? corPrimaria
                          : Theme.of(context).dividerColor,
                      width: selecionada ? 2.5 : 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        selecionada
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: selecionada ? corPrimaria : null,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          pergunta.opcoes[indice],
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
