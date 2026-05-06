import 'package:flutter/foundation.dart';

import '../../../mocks/mock_repository.dart';

/// Catégorie sélectionnée pour l’onglet « Catégorie ».
class SelectedCategoryNotifier extends ChangeNotifier {
  SelectedCategoryNotifier() : _categoryId = null;

  String? _categoryId;

  String? get categoryId => _categoryId;

  void select(String id) {
    if (_categoryId == id) return;
    _categoryId = id;
    notifyListeners();
  }
}
