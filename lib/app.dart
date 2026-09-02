import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_strings.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'providers/accessibility_provider.dart';
import 'providers/quiz_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccessibilityProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
      child: Consumer<AccessibilityProvider>(
        builder: (context, acessibilidade, _) {
          final temaBase = acessibilidade.altoContraste
              ? AppTheme.temaAltoContraste()
              : AppTheme.temaPadrao();

          return MaterialApp.router(
            title: AppStrings.nomeApp,
            debugShowCheckedModeBanner: false,
            theme: temaBase,
            routerConfig: appRouter,
            builder: (context, child) {
              final mediaQuery = MediaQuery.of(context);
              return MediaQuery(
                data: mediaQuery.copyWith(
                  textScaler: TextScaler.linear(acessibilidade.fontScale),
                ),
                child: child ?? const SizedBox.shrink(),
              );
            },
          );
        },
      ),
    );
  }
}
