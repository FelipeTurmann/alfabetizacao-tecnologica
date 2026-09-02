import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../models/security_tip.dart';
import '../../services/content_loader_service.dart';
import '../../widgets/accessible_app_bar.dart';
import '../../widgets/accessibility_toolbar.dart';
import '../../widgets/step_by_step_view.dart';

class SecurityDetailScreen extends StatefulWidget {
  final String id;

  const SecurityDetailScreen({super.key, required this.id});

  @override
  State<SecurityDetailScreen> createState() => _SecurityDetailScreenState();
}

class _SecurityDetailScreenState extends State<SecurityDetailScreen> {
  final _service = ContentLoaderService();
  late Future<SecurityTip?> _futureTip;

  @override
  void initState() {
    super.initState();
    _futureTip = _carregarDica();
  }

  Future<SecurityTip?> _carregarDica() async {
    final dicas = await _service.loadSecurityTips();
    try {
      return dicas.firstWhere((d) => d.id == widget.id);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AccessibleAppBar(titulo: AppStrings.menuSeguranca),
      body: Column(
        children: [
          const AccessibilityToolbar(),
          Expanded(
            child: FutureBuilder<SecurityTip?>(
              future: _futureTip,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                final dica = snapshot.data;
                if (dica == null) {
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
                    titulo: dica.titulo,
                    resumo: dica.resumo,
                    passos: dica.passos,
                    videoUrl: dica.video,
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
