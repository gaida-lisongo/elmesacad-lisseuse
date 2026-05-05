import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/providers.dart';
import 'views/library_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LiseuseApp());
}

class LiseuseApp extends StatelessWidget {
  const LiseuseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserNotifier()),
        ChangeNotifierProvider(create: (_) => ReadingProgressNotifier()),
      ],
      child: MaterialApp(
        title: 'Liseuse Elmes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF8B7355),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(centerTitle: false),
        ),
        home: const LibraryPage(),
      ),
    );
  }
}
