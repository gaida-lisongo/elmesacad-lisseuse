import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Carte charte : fond blanc, rayon 16, ombre noire à 5 %.
class ElmesCard extends StatelessWidget {
  const ElmesCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  static final List<BoxShadow> _shadow = [
    BoxShadow(
      color: AppColors.shadowLow(opacity: 0.05),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final box = Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: _shadow,
      ),
      child: Padding(padding: padding, child: child),
    );

    if (onTap == null) return box;
    return GestureDetector(onTap: onTap, child: box);
  }
}
