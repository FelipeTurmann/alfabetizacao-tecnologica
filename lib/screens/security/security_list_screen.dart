import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_strings.dart';
import '../../models/security_tip.dart';
import '../../services/content_loader_service.dart';
import '../../widgets/accessible_app_bar.dart';
import '../../widgets/accessibility_toolbar.dart';

class SecurityListScreen extends StatefulWidget {
  const SecurityListScreen({super.key});

  @override
  State<SecurityListScreen> createState() => _SecurityListScreenState();
}

class _SecurityListScreenState extends State<SecurityListScreen> {
  final _service = ContentLoaderService();
  late Future<List<SecurityTip>> _futureTips;

  @override
  void initState() {
    super.initState();
    _futureTips = _service.loadSecurityTips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AccessibleAppBar(titulo: AppStrings.menuSeguranca),
      body: Column(
        children: [
          const AccessibilityToolbar(),
          Expanded(
            child: FutureBuilder<List<SecurityTip>>(
              future: _futureTips,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError || !snapshot.hasData) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        AppStrings.erroCarregar,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                final dicas = snapshot.data!;
                return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: dicas.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final dica = dicas[index];
                    return Semantics(
                      button: true,
                      label:
                          'Abrir orientação: ${dica.titulo}. ${dica.resumo}',
                      child: Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundColor:
                                Colors.deepOrange.shade700.withOpacity(0.15),
                            child: Icon(
                              _iconePorNome(dica.icone),
                              color: Colors.deepOrange.shade700,
                              size: 28,
                            ),
                          ),
                          title: Text(
                            dica.titulo,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              dica.resumo,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right, size: 28),
                          onTap: () => context.go('/seguranca/${dica.id}'),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconePorNome(String nome) {
    switch (nome) {
      case 'warning_amber':
        return Icons.warning_amber;
      case 'mark_email_unread':
        return Icons.mark_email_unread;
      case 'link':
        return Icons.link;
      case 'gpp_maybe':
        return Icons.gpp_maybe;
      case 'lock':
        return Icons.lock;
      case 'privacy_tip':
        return Icons.privacy_tip;
      case 'apps':
        return Icons.apps;
      case 'verified_user':
        return Icons.verified_user;
      default:
        return Icons.shield;
    }
  }
}
