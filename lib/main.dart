import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'app/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/category/providers/selected_category_provider.dart';
import 'features/reader/providers/reading_progress_provider.dart';
import 'features/user/providers/user_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(LiseuseApp(router: createAppRouter()));
}

class LiseuseApp extends StatelessWidget {
  const LiseuseApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ReadingProgressNotifier()),
        ChangeNotifierProvider(create: (_) => SelectedCategoryNotifier()),
      ],
      child: MaterialApp.router(
        title: 'ELMESACAD',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: router,
      ),
    );
  }
}
