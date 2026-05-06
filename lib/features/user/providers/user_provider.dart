import 'package:flutter/foundation.dart';

import '../../../mocks/mock_repository.dart';
import '../../../models/user.dart';

/// État utilisateur et solde crédits (Provider).
class UserProvider extends ChangeNotifier {
  UserProvider() : _user = MockRepository.mockUser;

  User _user;

  User get user => _user;

  /// Débit par page lue (.cursorrules).
  static const double pageCreditCost = 1.15;

  void replaceUser(User value) {
    _user = value;
    notifyListeners();
  }

  /// Soustrait exactement [pageCreditCost] au solde à chaque appel.
  void deductPageCredit() {
    _user = _user.copyWith(credits: _user.credits - pageCreditCost);
    notifyListeners();
  }

  void setCredits(double credits) {
    _user = _user.copyWith(credits: credits);
    notifyListeners();
  }
}
