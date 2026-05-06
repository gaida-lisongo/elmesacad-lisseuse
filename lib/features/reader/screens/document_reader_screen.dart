import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/widgets.dart';
import '../../../mocks/mock_repository.dart';
import '../../../models/document.dart';
import '../providers/reading_progress_provider.dart';
import '../../user/providers/user_provider.dart';

class DocumentReaderScreen extends StatefulWidget {
  const DocumentReaderScreen({super.key, required this.documentId});

  final String documentId;

  @override
  State<DocumentReaderScreen> createState() => _DocumentReaderScreenState();
}

class _DocumentReaderScreenState extends State<DocumentReaderScreen> {
  late final PageController _pageController;
  Document? _document;
  late List<DocumentPage> _pages;
  int _index = 0;
  bool _chromeVisible = true;
  int? _previousPageForBilling;

  @override
  void initState() {
    super.initState();
    _document = MockRepository.documentById(widget.documentId);
    _pages = _document?.pagesSorted ?? const [];
    final saved = context.read<ReadingProgressNotifier>().lastPageIndexFor(
          widget.documentId,
        );
    final initial =
        _pages.isEmpty ? 0 : saved.clamp(0, _pages.length - 1).toInt();
    _index = initial;
    _pageController = PageController(initialPage: initial);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle());
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int i) {
    if (_previousPageForBilling != null &&
        _previousPageForBilling != i) {
      context.read<UserProvider>().deductPageCredit();
    }
    _previousPageForBilling = i;

    setState(() => _index = i);
    context.read<ReadingProgressNotifier>().setLastPageIndex(
          widget.documentId,
          i,
        );
  }

  void _toggleChrome() => setState(() => _chromeVisible = !_chromeVisible);

  void _goToPage(int page) {
    if (_pages.isEmpty) return;
    final clamped = page.clamp(0, _pages.length - 1).toInt();
    if (clamped == _index) return;
    setState(() => _index = clamped);
    _pageController.animateToPage(
      clamped,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
    context.read<ReadingProgressNotifier>().setLastPageIndex(
          widget.documentId,
          clamped,
        );
  }

  @override
  Widget build(BuildContext context) {
    final doc = _document;
    if (doc == null || _pages.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Document')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Document introuvable.'),
              const Spacer(),
              ElmesButton(
                label: 'Fermer',
                onPressed: () => context.pop(),
              ),
            ],
          ),
        ),
      );
    }

    final theme = Theme.of(context);
    final maxIdx = (_pages.length - 1).clamp(0, 1 << 30).toInt();

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _toggleChrome,
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, i) {
                final page = _pages[i];
                return Center(
                  child: InteractiveViewer(
                    minScale: 1,
                    maxScale: 4,
                    child: Image.network(
                      page.url,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const SizedBox(
                          height: 320,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) => const Padding(
                        padding: EdgeInsets.all(24),
                        child: Icon(
                          Icons.broken_image_outlined,
                          color: Colors.white54,
                          size: 64,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            if (_chromeVisible)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Material(
                  color: Colors.black.withOpacity(0.55),
                  child: SafeArea(
                    bottom: false,
                    child: ListTile(
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => context.pop(),
                      ),
                      title: Text(
                        doc.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        '${_index + 1} / ${_pages.length}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      trailing: Consumer<UserProvider>(
                        builder: (context, userNotifier, _) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              '${userNotifier.user.credits.toStringAsFixed(2)} cr.',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            if (_chromeVisible)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Material(
                  color: Colors.black.withOpacity(0.55),
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _pages[_index].comment,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ),
                              Text(
                                '${_index + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: _index.toDouble(),
                            min: 0,
                            max: maxIdx.toDouble(),
                            divisions: maxIdx == 0 ? null : maxIdx,
                            label: '${_index + 1}',
                            activeColor: AppColors.primary,
                            inactiveColor: Colors.white24,
                            onChanged: (v) => _goToPage(v.round()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
