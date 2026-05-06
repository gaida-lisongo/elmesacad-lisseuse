import 'package:flutter/foundation.dart';

import '../../../models/models.dart';

/// État utilisateur, documents et catégories (Provider).
class UserProvider extends ChangeNotifier {
  UserProvider() : _user = null, _documents = [], _categories = [];

  User? _user;
  List<Document> _documents;
  List<Categorie> _categories;

  User? get user => _user;
  List<Document> get documents => _documents;
  List<Categorie> get categories => _categories;

  bool get isAuthenticated => _user != null;

  /// Débit par page lue (doit correspondre à CREDITS_PER_PROGRESS_UPDATE du backend).
  static const double pageCreditCost = 1.15;

  void setUserData(User user, List<Document> documents, List<Categorie> categories) {
    _user = user;
    _documents = documents;
    _categories = categories;
    notifyListeners();
  }

  void logout() {
    _user = null;
    _documents = [];
    _categories = [];
    notifyListeners();
  }

  /// Met à jour les crédits (appelé après sync backend).
  void setCredits(double credits) {
    if (_user == null) return;
    _user = _user!.copyWith(credits: credits);
    notifyListeners();
  }
}
