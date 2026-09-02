import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccessibleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;

  const AccessibleAppBar({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titulo),
      leading: Semantics(
        button: true,
        label: 'Voltar para a tela anterior',
        child: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
