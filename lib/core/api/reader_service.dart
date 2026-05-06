import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class ReaderService {
  /// Met à jour la progression de lecture et synchronise les crédits avec le backend.
  /// Retourne les crédits restants et les pages mises à jour.
  Future<Map<String, dynamic>?> updateProgress({
    required String documentId,
    required String userId,
    required int newPage,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse('${ApiConfig.fullUrl}/reader/update-progress'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'document_id': documentId,
          'user_id': userId,
          'new_page': newPage,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>?;
      }
      print('Error updating progress: ${response.statusCode} - ${response.body}');
      return null;
    } catch (e) {
      print('Error updating progress: $e');
      return null;
    }
  }
}
