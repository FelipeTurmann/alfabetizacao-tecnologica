import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_strings.dart';
import '../../widgets/accessible_app_bar.dart';
import '../../widgets/accessibility_toolbar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _abrirLink(BuildContext context) async {
    final uri = Uri.parse(AppStrings.linkSobreUrl);
    final abriu = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!abriu && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o link.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AccessibleAppBar(titulo: AppStrings.menuSobre),
      body: Column(
        children: [
          const AccessibilityToolbar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info,
                    size: 56,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppStrings.nomeApp,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppStrings.sobreTexto,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 28),
                  Semantics(
                    button: true,
                    link: true,
                    label:
                        '${AppStrings.linkSobreTitulo}. Abre em uma nova aba do navegador.',
                    child: OutlinedButton.icon(
                      onPressed: () => _abrirLink(context),
                      icon: const Icon(Icons.open_in_new),
                      label: const Text(AppStrings.linkSobreTitulo),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
