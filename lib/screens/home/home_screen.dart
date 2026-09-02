import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_strings.dart';
import '../../widgets/accessibility_toolbar.dart';
import '../../widgets/large_nav_card.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AccessibilityToolbar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Icon(
                      Icons.diversity_3,
                      size: 56,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.tituloInicial,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.subtituloInicial,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 32),
                    LargeNavCard(
                      icone: Icons.menu_book,
                      titulo: AppStrings.menuTutoriais,
                      descricao: AppStrings.descricaoTutoriais,
                      cor: Colors.blue.shade700,
                      onTap: () => context.go('/tutoriais'),
                    ),
                    const SizedBox(height: 16),
                    LargeNavCard(
                      icone: Icons.shield,
                      titulo: AppStrings.menuSeguranca,
                      descricao: AppStrings.descricaoSeguranca,
                      cor: Colors.deepOrange.shade700,
                      onTap: () => context.go('/seguranca'),
                    ),
                    const SizedBox(height: 16),
                    LargeNavCard(
                      icone: Icons.quiz,
                      titulo: AppStrings.menuQuiz,
                      descricao: AppStrings.descricaoQuiz,
                      cor: Colors.purple.shade700,
                      onTap: () => context.go('/quiz'),
                    ),
                    const SizedBox(height: 16),
                    LargeNavCard(
                      icone: Icons.info,
                      titulo: AppStrings.menuSobre,
                      descricao: AppStrings.descricaoSobre,
                      cor: Colors.teal.shade700,
                      onTap: () => context.go('/sobre'),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
