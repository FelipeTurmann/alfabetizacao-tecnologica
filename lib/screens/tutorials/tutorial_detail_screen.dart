import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../models/tutorial.dart';
import '../../services/content_loader_service.dart';
import '../../widgets/accessible_app_bar.dart';
import '../../widgets/accessibility_toolbar.dart';
import '../../widgets/step_by_step_view.dart';

class TutorialDetailScreen extends StatefulWidget {
  final String id;

  const TutorialDetailScreen({super.key, required this.id});

  @override
  State<TutorialDetailScreen> createState() => _TutorialDetailScreenState();
}

class _TutorialDetailScreenState extends State<TutorialDetailScreen> {
  final _service = ContentLoaderService();
  late Future<Tutorial?> _futureTutorial;

  @override
  void initState() {
    super.initState();
    _futureTutorial = _carregarTutorial();
  }

  Future<Tutorial?> _carregarTutorial() async {
    final tutoriais = await _service.loadTutorials();
    try {
      return tutoriais.firstWhere((t) => t.id == widget.id);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AccessibleAppBar(titulo: AppStrings.menuTutoriais),
      body: Column(
        children: [
          const AccessibilityToolbar(),
          Expanded(
            child: FutureBuilder<Tutorial?>(
              future: _futureTutorial,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                final tutorial = snapshot.data;
                if (tutorial == null) {
                  return Center(
                    child: Text(
                      AppStrings.erroCarregar,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  );
                }
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: StepByStepView(
                    titulo: tutorial.titulo,
                    resumo: tutorial.resumo,
                    passos: tutorial.passos,
                    videoUrl: tutorial.video,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
