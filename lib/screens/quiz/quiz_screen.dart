import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_strings.dart';
import '../../providers/quiz_provider.dart';
import '../../widgets/accessible_app_bar.dart';
import '../../widgets/accessibility_toolbar.dart';
import '../../widgets/quiz_question_card.dart';


class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizProvider>().iniciarNovoQuiz();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AccessibleAppBar(titulo: AppStrings.menuQuiz),
      body: Column(
        children: [
          const AccessibilityToolbar(),
          Expanded(
            child: Consumer<QuizProvider>(
              builder: (context, quiz, _) {
                switch (quiz.status) {
                  case QuizStatus.carregando:
                    return const Center(child: CircularProgressIndicator());

                  case QuizStatus.erro:
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppStrings.erroCarregar,
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => quiz.iniciarNovoQuiz(),
                              child: const Text(AppStrings.tentarNovamente),
                            ),
                          ],
                        ),
                      ),
                    );

                  case QuizStatus.finalizado:
                    // Navega para a tela de resultado assim que
                    // a última resposta é confirmada.
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (context.mounted) context.go('/quiz/resultado');
                    });
                    return const Center(child: CircularProgressIndicator());

                  case QuizStatus.emAndamento:
                    final pergunta = quiz.perguntaAtual;
                    if (pergunta == null) {
                      return const SizedBox.shrink();
                    }
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          QuizQuestionCard(
                            pergunta: pergunta,
                            numero: quiz.indiceAtual + 1,
                            total: quiz.totalPerguntas,
                            respostaSelecionada: quiz.respostaSelecionadaAtual,
                            onSelecionar: quiz.selecionarResposta,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: quiz.respostaSelecionadaAtual == null
                                ? null
                                : quiz.avancar,
                            child: Text(
                              quiz.isUltimaPergunta
                                  ? AppStrings.verResultado
                                  : AppStrings.confirmarEContinuar,
                            ),
                          ),
                        ],
                      ),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
