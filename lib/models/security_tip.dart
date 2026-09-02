import 'tutorial.dart' show TutorialStep;

class SecurityTip {
  final String id;
  final String titulo;
  final String categoria;
  final String icone;
  final String resumo;
  final List<TutorialStep> passos;
  final String? video;

  SecurityTip({
    required this.id,
    required this.titulo,
    required this.categoria,
    required this.icone,
    required this.resumo,
    required this.passos,
    this.video,
  });

  factory SecurityTip.fromJson(Map<String, dynamic> json) => SecurityTip(
        id: json['id'] as String,
        titulo: json['titulo'] as String,
        categoria: json['categoria'] as String,
        icone: json['icone'] as String,
        resumo: json['resumo'] as String? ?? '',
        passos: (json['passos'] as List)
            .map((p) => TutorialStep.fromJson(p as Map<String, dynamic>))
            .toList(),
        video: json['video'] as String?,
      );
}
