import 'package:flutter/foundation.dart';

/// Dernière page lue par document (`documentId` → index de page affiché).
class ReadingProgressNotifier extends ChangeNotifier {
  final Map<String, int> _lastPageIndexByDocumentId = {};

  int lastPageIndexFor(String documentId) =>
      _lastPageIndexByDocumentId[documentId] ?? 0;

  void setLastPageIndex(String documentId, int pageIndex) {
    final current = _lastPageIndexByDocumentId[documentId];
    if (current == pageIndex) return;
    _lastPageIndexByDocumentId[documentId] = pageIndex;
    notifyListeners();
  }

  void clearDocument(String documentId) {
    _lastPageIndexByDocumentId.remove(documentId);
    notifyListeners();
  }
}
