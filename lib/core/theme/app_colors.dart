import 'package:flutter/material.dart';

/// Charte graphique ELMESACAD (.cursorrules).
abstract final class AppColors {
  static const Color primary = Color(0xFF058AC5);
  static const Color secondary = Color(0xFFE76067);
  static const Color black = Color(0xFF272826);
  static const Color gray = Color(0xFFD4D6D3);
  static const Color white = Color(0xFFFFFFFF);
  static const Color green = Color(0xFF5ECB44);

  /// Ombre standard : noir charte à très faible opacité.
  static Color shadowLow({double opacity = 0.05}) =>
      black.withOpacity(opacity);
}
