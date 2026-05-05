import 'package:flutter/foundation.dart';

import '../models/user.dart';
import '../mocks/mock_repository.dart';

class UserNotifier extends ChangeNotifier {
  UserNotifier() : _user = MockRepository.mockUser;

  User _user;

  User get user => _user;

  void replaceUser(User value) {
    _user = value;
    notifyListeners();
  }

  /// Ajuste le solde (ex. consommation d’une page — logique métier à brancher plus tard).
  void applyCreditsDelta(int delta) {
    _user = _user.copyWith(credits: _user.credits + delta);
    notifyListeners();
  }

  void setCredits(int credits) {
    _user = _user.copyWith(credits: credits);
    notifyListeners();
  }
}
