import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_strings.dart';
import '../../providers/quiz_provider.dart';
import '../../widgets/accessible_app_bar.dart';
import '../../widgets/accessibility_toolbar.dart';


class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final acertos = quiz.pontuacaoFinal;
    final total = quiz.totalPerguntas == 0 ? 5 : quiz.totalPerguntas;

    return Scaffold(
      appBar: const AccessibleAppBar(titulo: AppStrings.menuQuiz),
      body: Column(
        children: [
          const AccessibilityToolbar(),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _iconeParaResultado(acertos, total),
                      size: 96,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Você acertou $acertos de $total',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _mensagemIncentivo(acertos, total),
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<QuizProvider>().iniciarNovoQuiz();
                        context.go('/quiz');
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text(AppStrings.tentarNovamente),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () => context.go('/'),
                      icon: const Icon(Icons.home),
                      label: const Text(AppStrings.voltarInicio),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconeParaResultado(int acertos, int total) {
    if (acertos == total) return Icons.emoji_events;
    if (acertos >= (total / 2)) return Icons.thumb_up;
    return Icons.favorite;
  }

  String _mensagemIncentivo(int acertos, int total) {
    if (acertos == total) {
      return 'Parabéns! Você acertou todas as perguntas!';
    }
    if (acertos >= (total / 2)) {
      return 'Muito bem! Continue praticando para aprender ainda mais.';
    }
    return 'Continue tentando! Revisite os tutoriais e as dicas de segurança sempre que quiser.';
  }
}
