import 'package:flutter/material.dart';

class LargeNavCard extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String descricao;
  final Color cor;
  final VoidCallback onTap;

  const LargeNavCard({
    super.key,
    required this.icone,
    required this.titulo,
    required this.descricao,
    required this.cor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$titulo. $descricao',
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: cor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icone, size: 36, color: cor),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        descricao,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right,
                    size: 32, color: Theme.of(context).colorScheme.primary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
