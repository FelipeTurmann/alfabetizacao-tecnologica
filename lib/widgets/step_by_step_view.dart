import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import '../core/constants/app_strings.dart';
import '../models/tutorial.dart' show TutorialStep;

class StepByStepView extends StatefulWidget {
  final String titulo;
  final String resumo;
  final List<TutorialStep> passos;
  final String? videoUrl;

  const StepByStepView({
    super.key,
    required this.titulo,
    required this.resumo,
    required this.passos,
    this.videoUrl,
  });

  @override
  State<StepByStepView> createState() => _StepByStepViewState();
}

class _StepByStepViewState extends State<StepByStepView> {
  int _passoAtual = 0;
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _inicializarVideoSeExistir();
  }

  void _inicializarVideoSeExistir() {
    final url = widget.videoUrl;
    if (url != null && url.isNotEmpty) {
      _videoController = VideoPlayerController.networkUrl(Uri.parse(url))
        ..initialize().then((_) => setState(() {}));
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  bool get _isUltimoPasso => _passoAtual == widget.passos.length - 1;

  @override
  Widget build(BuildContext context) {
    final passo = widget.passos[_passoAtual];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.titulo,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(widget.resumo, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 20),
        if (_videoController != null && _videoController!.value.isInitialized)
          AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          ),
        const SizedBox(height: 12),
        Text(
          'Passo ${_passoAtual + 1} de ${widget.passos.length}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (passo.imagem != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        passo.imagem!,
                        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                      ),
                    ),
                  ),
                Text(
                  passo.texto,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            if (_passoAtual > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: () => setState(() => _passoAtual--),
                  child: const Text(AppStrings.passoAnterior),
                ),
              ),
            if (_passoAtual > 0) const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: _isUltimoPasso
                    ? () => context.canPop() ? context.pop() : context.go('/')
                    : () => setState(() => _passoAtual++),
                child: Text(
                  _isUltimoPasso
                      ? AppStrings.concluir
                      : AppStrings.proximoPasso,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
