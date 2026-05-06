import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/api/auth_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/widgets.dart';
import '../../user/providers/user_provider.dart';

/// Simulation de connexion par scan QR : succès mock → UUID fixe.
/// Fallback : saisie manuelle du matricule.
class LoginQrScreen extends StatefulWidget {
  const LoginQrScreen({super.key});

  @override
  State<LoginQrScreen> createState() => _LoginQrScreenState();
}

class _LoginQrScreenState extends State<LoginQrScreen> {
  final TextEditingController _matriculeController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _matriculeController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final matricule = _matriculeController.text.trim();
    if (matricule.isEmpty) {
      setState(() => _error = 'Veuillez entrer votre matricule');
      return;
    }

    setState(() {
      _busy = true;
      _error = null;
    });

    final result = await _authService.login(matricule);

    if (!mounted) return;

    if (result != null) {
      context.read<UserProvider>().setUserData(
            result.user,
            result.documents,
            result.categories,
          );
      context.go('/main/home');
    } else {
      setState(() {
        _busy = false;
        _error = 'Erreur de connexion : matricule invalide ou serveur injoignable';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElmesCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(
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
                    'Ou saisissez votre matricule ci-dessous',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.black.withOpacity(0.55),
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElmesInput(
              controller: _matriculeController,
              labelText: 'Matricule',
              hintText: 'Ex: ELM-20488',
              onChanged: (_) => setState(() => _error = null),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(
                _error!,
                style: const TextStyle(color: AppColors.secondary, fontSize: 12),
              ),
            ],
            const SizedBox(height: 24),
            if (_busy)
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              ),
            ElmesButton(
              label: 'Se connecter',
              onPressed: _busy ? null : _handleLogin,
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
