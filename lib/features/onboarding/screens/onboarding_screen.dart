import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_page < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    } else {
      context.go('/login-qr');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenue'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                children: const [
                  _OnboardingStep(
                    title: 'Votre bibliothèque',
                    body:
                        'Retrouvez les documents achetés sur ELMESACAD, organisés par catégorie.',
                  ),
                  _OnboardingStep(
                    title: 'Lecture fluide',
                    body:
                        'Feuilletez les pages comme sur une liseuse : zoom, navigation rapide.',
                  ),
                  _OnboardingStep(
                    title: 'Crédits transparents',
                    body:
                        'Chaque page consultée utilise vos crédits selon les règles du service.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor:
                        i == _page ? AppColors.primary : AppColors.gray,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElmesButton(
              label: _page < 2 ? 'Suivant' : 'Commencer',
              onPressed: _next,
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingStep extends StatelessWidget {
  const _OnboardingStep({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElmesCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.auto_stories_rounded, color: AppColors.primary, size: 40),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                body,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.black.withOpacity(0.75),
                      height: 1.4,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
