import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum ElmesButtonVariant { primary, secondary }

/// Bouton charte : coins 12px, élévation 2. Primary / Secondary (fond blanc, bord gris).
class ElmesButton extends StatelessWidget {
  const ElmesButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = ElmesButtonVariant.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final ElmesButtonVariant variant;

  static const double _radius = 12;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case ElmesButtonVariant.primary:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 2,
            shadowColor: AppColors.shadowLow(),
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            disabledBackgroundColor: AppColors.gray,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_radius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
          child: Text(label),
        );
      case ElmesButtonVariant.secondary:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 2,
            shadowColor: AppColors.shadowLow(),
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.black,
            disabledBackgroundColor: AppColors.gray.withOpacity(0.4),
            side: const BorderSide(color: AppColors.gray, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_radius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
          child: Text(label),
        );
    }
  }
}
