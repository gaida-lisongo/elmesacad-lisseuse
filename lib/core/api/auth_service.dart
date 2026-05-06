import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import '../../models/models.dart';

class AuthResult {
  const AuthResult({
    required this.user,
    required this.documents,
    required this.categories,
  });

  final User user;
  final List<Document> documents;
  final List<Categorie> categories;
}

class AuthService {
  Future<AuthResult?> login(String matricule) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.fullUrl}/auth/matricule'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'matricule': matricule}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map<String, dynamic>) {
          final userData = data['user'] as Map<String, dynamic>?;
          final docsData = data['documents'] as List<dynamic>?;
          final catsData = data['categories'] as List<dynamic>?;

          if (userData != null) {
            final user = User.fromJson(userData);
            final documents = docsData != null
                ? docsData.map((json) => Document.fromJson(json as Map<String, dynamic>)).toList()
                : <Document>[];
            final categories = catsData != null
                ? catsData.map((json) => Categorie.fromJson(json as Map<String, dynamic>)).toList()
                : <Categorie>[];
            return AuthResult(
              user: user,
              documents: documents,
              categories: categories,
            );
          }
        }
      }
      return null;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }
}
