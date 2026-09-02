import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:alfabetizacao_tecnologica/core/constants/app_strings.dart';
import 'package:alfabetizacao_tecnologica/core/theme/app_theme.dart';
import 'package:alfabetizacao_tecnologica/providers/accessibility_provider.dart';
import 'package:alfabetizacao_tecnologica/screens/home/home_screen.dart';

Widget _wrapComRotas() {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/tutoriais', builder: (_, __) => const Placeholder()),
      GoRoute(path: '/seguranca', builder: (_, __) => const Placeholder()),
      GoRoute(path: '/quiz', builder: (_, __) => const Placeholder()),
      GoRoute(path: '/sobre', builder: (_, __) => const Placeholder()),
    ],
  );

  return ChangeNotifierProvider(
    create: (_) => AccessibilityProvider(),
    child: MaterialApp.router(
      theme: AppTheme.temaPadrao(),
      routerConfig: router,
    ),
  );
}

void main() {
  testWidgets('HomeScreen exibe os quatro cartões de navegação principais',
      (tester) async {
    await tester.pumpWidget(_wrapComRotas());
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.menuTutoriais), findsOneWidget);
    expect(find.text(AppStrings.menuSeguranca), findsOneWidget);
    expect(find.text(AppStrings.menuQuiz), findsOneWidget);
    expect(find.text(AppStrings.menuSobre), findsOneWidget);
  });

  testWidgets('Barra de acessibilidade altera a escala de fonte',
      (tester) async {
    await tester.pumpWidget(_wrapComRotas());
    await tester.pumpAndSettle();

    final provider = tester
        .element(find.byType(HomeScreen))
        .read<AccessibilityProvider>();

    final escalaInicial = provider.fontScale;

    await tester.tap(find.byIcon(Icons.text_increase));
    await tester.pumpAndSettle();

    expect(provider.fontScale, greaterThan(escalaInicial));
  });
}
