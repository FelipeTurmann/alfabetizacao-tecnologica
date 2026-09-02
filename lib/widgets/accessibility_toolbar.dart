import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_strings.dart';
import '../providers/accessibility_provider.dart';


class AccessibilityToolbar extends StatelessWidget {
  const AccessibilityToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    final acessibilidade = context.watch<AccessibilityProvider>();

    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Semantics(
            button: true,
            label: AppStrings.diminuirFonte,
            child: IconButton(
              iconSize: 32,
              tooltip: AppStrings.diminuirFonte,
              onPressed: acessibilidade.diminuirFonte,
              icon: const Icon(Icons.text_decrease),
            ),
          ),
          Semantics(
            button: true,
            label: AppStrings.aumentarFonte,
            child: IconButton(
              iconSize: 32,
              tooltip: AppStrings.aumentarFonte,
              onPressed: acessibilidade.aumentarFonte,
              icon: const Icon(Icons.text_increase),
            ),
          ),
          const SizedBox(width: 8),
          Semantics(
            button: true,
            label: AppStrings.alternarContraste,
            child: IconButton(
              iconSize: 32,
              tooltip: AppStrings.alternarContraste,
              onPressed: acessibilidade.alternarContraste,
              icon: Icon(
                acessibilidade.altoContraste
                    ? Icons.contrast
                    : Icons.contrast_outlined,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
