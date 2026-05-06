import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/widgets.dart';

/// Simulation de connexion par scan QR : succès mock → UUID fixe.
class LoginQrScreen extends StatefulWidget {
  const LoginQrScreen({super.key});

  @override
  State<LoginQrScreen> createState() => _LoginQrScreenState();
}

class _LoginQrScreenState extends State<LoginQrScreen> {
  static const String _mockSessionUuid =
      'a7f2c9e1-4b3d-4c8a-9f01-123456789abc';

  bool _busy = false;

  Future<void> _simulateScan() async {
    setState(() => _busy = true);
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _busy = false);
    context.go('/main/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion QR')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElmesCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(
                    Icons.qr_code_scanner_rounded,
                    size: 72,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Scannez votre badge ELMESACAD',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Mock : session UUID\n$_mockSessionUuid',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.black.withOpacity(0.55),
                        ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (_busy)
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              ),
            ElmesButton(
              label: 'Simuler un scan réussi',
              onPressed: _busy ? null : _simulateScan,
            ),
            const SizedBox(height: 12),
            ElmesButton(
              label: 'Retour',
              variant: ElmesButtonVariant.secondary,
              onPressed: _busy ? null : () => context.go('/onboarding'),
            ),
          ],
        ),
      ),
    );
  }
}
