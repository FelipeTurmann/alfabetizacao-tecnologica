import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_strings.dart';
import '../../models/tutorial.dart';
import '../../services/content_loader_service.dart';
import '../../widgets/accessible_app_bar.dart';
import '../../widgets/accessibility_toolbar.dart';

class TutorialListScreen extends StatefulWidget {
  const TutorialListScreen({super.key});

  @override
  State<TutorialListScreen> createState() => _TutorialListScreenState();
}

class _TutorialListScreenState extends State<TutorialListScreen> {
  final _service = ContentLoaderService();
  late Future<List<Tutorial>> _futureTutorials;

  @override
  void initState() {
    super.initState();
    _futureTutorials = _service.loadTutorials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AccessibleAppBar(titulo: AppStrings.menuTutoriais),
      body: Column(
        children: [
          const AccessibilityToolbar(),
          Expanded(
            child: FutureBuilder<List<Tutorial>>(
              future: _futureTutorials,
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

                final tutoriais = snapshot.data!;
                return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: tutoriais.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final tutorial = tutoriais[index];
                    return Semantics(
                      button: true,
                      label:
                          'Abrir tutorial: ${tutorial.titulo}. ${tutorial.resumo}',
                      child: Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.15),
                            child: Icon(
                              _iconePorNome(tutorial.icone),
                              color: Theme.of(context).colorScheme.primary,
                              size: 28,
                            ),
                          ),
                          title: Text(
                            tutorial.titulo,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              tutorial.resumo,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right, size: 28),
                          onTap: () =>
                              context.go('/tutoriais/${tutorial.id}'),
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
      case 'phone_android':
        return Icons.phone_android;
      case 'call':
        return Icons.call;
      case 'chat':
        return Icons.chat;
      case 'photo_camera':
        return Icons.photo_camera;
      case 'wifi':
        return Icons.wifi;
      case 'search':
        return Icons.search;
      case 'get_app':
        return Icons.get_app;
      default:
        return Icons.menu_book;
    }
  }
}
