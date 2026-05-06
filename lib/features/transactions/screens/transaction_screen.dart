import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/widgets.dart';
import '../../user/providers/user_provider.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: Consumer<UserProvider>(
        builder: (context, userNotifier, _) {
          final list = userNotifier.user.recharges;
          if (list.isEmpty) {
            return const Center(child: Text('Aucune recharge pour le moment.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final r = list[index];
              return ElmesCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            r.orderNumber,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        _StatusChip(status: r.status),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '+${r.credits} crédits',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Màj : ${r.updatedAt.toLocal()}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.black.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  Color _color() {
    switch (status) {
      case 'completed':
        return AppColors.green;
      case 'paid':
        return AppColors.primary;
      case 'failed':
        return AppColors.secondary;
      default:
        return AppColors.gray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color().withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: _color(),
        ),
      ),
    );
  }
}
