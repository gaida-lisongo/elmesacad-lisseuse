import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../mocks/mock_repository.dart';
import '../providers/providers.dart';
import 'reader_page.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = MockRepository.mockCategories;
    final byCat = MockRepository.documentsByCategoryId();

    return Scaffold(
      backgroundColor: const Color(0xFFF3ECD7),
      appBar: AppBar(
        title: const Text('Bibliothèque'),
        backgroundColor: const Color(0xFFE8DCC4),
        foregroundColor: const Color(0xFF2C2416),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Consumer<UserNotifier>(
              builder: (context, userNotifier, _) {
                return Chip(
                  avatar: const Icon(Icons.monetization_on_outlined, size: 18),
                  label: Text('${userNotifier.user.credits} crédits'),
                  backgroundColor: const Color(0xFFD8C9A8),
                );
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final docs = byCat[cat.id] ?? const <Document>[];
          return _CategorySection(categorie: cat, documents: docs);
        },
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.categorie,
    required this.documents,
  });

  final Categorie categorie;
  final List<Document> documents;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFFBF2),
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        initiallyExpanded: documents.isNotEmpty,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          categorie.designation,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C2416),
          ),
        ),
        subtitle: Text(
          '${documents.length} document(s) · ${categorie.reference}',
          style: TextStyle(color: Colors.brown.shade700, fontSize: 13),
        ),
        children: [
          if (documents.isEmpty)
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Aucun document dans cette catégorie pour le moment.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            )
          else
            ...documents.map((d) => _DocumentTile(document: d)),
        ],
      ),
    );
  }
}

class _DocumentTile extends StatelessWidget {
  const _DocumentTile({required this.document});

  final Document document;

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ReadingProgressNotifier>();
    final last = progress.lastPageIndexFor(document.id);
    final total = document.pages.length;
    final pct = total == 0 ? 0.0 : ((last + 1) / total).clamp(0.0, 1.0);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: AspectRatio(
          aspectRatio: 400 / 600,
          child: Image.network(
            document.pagesSorted.first.url,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: const Color(0xFFD8C9A8),
              child: const Icon(Icons.menu_book_outlined),
            ),
          ),
        ),
      ),
      title: Text(
        document.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(document.author.name),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: pct,
            minHeight: 4,
            borderRadius: BorderRadius.circular(4),
            backgroundColor: const Color(0xFFE5DAC4),
            color: const Color(0xFF8B7355),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => ReaderPage(document: document),
          ),
        );
      },
    );
  }
}
