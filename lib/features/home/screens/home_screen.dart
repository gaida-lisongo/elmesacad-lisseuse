import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/widgets.dart';
import '../../../models/models.dart';
import '../../category/providers/selected_category_provider.dart';
import '../../user/providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final userProvider = context.read<UserProvider>();
    final user = userProvider.user;
    if (user == null) return;

    setState(() => _isLoading = true);
    
    // Les données sont déjà chargées via UserProvider
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.go('/main/profile'),
            tooltip: 'Profil',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : RefreshIndicator(
              onRefresh: _loadData,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Consumer<UserProvider>(
                      builder: (context, userProvider, _) {
                        final user = userProvider.user;
                        if (user == null) return const SizedBox.shrink();
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _StatCard(
                                    title: 'Crédits',
                                    value: user.credits.toStringAsFixed(2),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _StatCard(
                                    title: 'Documents',
                                    value: '${user.metrics.documents}',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _StatCard(
                                    title: 'Catégories',
                                    value: '${user.metrics.categories}',
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _StatCard(
                                    title: 'Pages',
                                    value: '${user.metrics.pages}',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _StatCard(
                              title: 'Transactions',
                              value: '${user.recharges.length}',
                            ),
                            if (user.recharges.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: user.recharges.length,
                                  itemBuilder: (context, index) {
                                    final recharge = user.recharges[index];
                                    return Container(
                                      width: 200,
                                      margin: const EdgeInsets.only(right: 16),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Recharge ${recharge.orderNumber}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${recharge.credits} crédits',
                                            style: TextStyle(
                                              color: AppColors.black.withOpacity(0.7),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            recharge.status,
                                            style: TextStyle(
                                              color: recharge.status == 'completed' ? Colors.green : AppColors.gray,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Catégories',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Consumer<UserProvider>(
                      builder: (context, userProvider, child) {
                        final categories = userProvider.categories;
                        if (categories.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: Text(
                              'Aucune catégorie trouvée.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppColors.gray),
                            ),
                          );
                        }
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.05,
                          ),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final cat = categories[index];
                            return ElmesCard(
                              onTap: () {
                                context.read<SelectedCategoryNotifier>().select(cat.id);
                                context.go('/main/category');
                              },
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.category,
                                    size: 32,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    cat.designation,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${cat.documents.length} document(s)',
                                    style: TextStyle(
                                      color: AppColors.black.withOpacity(0.55),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ElmesCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.black.withOpacity(0.55),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
