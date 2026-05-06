import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import '../../models/models.dart';

class DataService {
  Future<List<Categorie>> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.fullUrl}/categories'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Categorie.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  Future<List<Document>> getDocuments(String userId) async {
    try {
      // On suppose que l'API a un endpoint pour les documents d'un utilisateur
      final response = await http.get(
        Uri.parse('${ApiConfig.fullUrl}/documents?userId=$userId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Document.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching documents: $e');
      return [];
    }
  }

  Future<Document?> getDocumentById(String documentId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.fullUrl}/documents/$documentId'),
      );

      if (response.statusCode == 200) {
        return Document.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      print('Error fetching document: $e');
      return null;
    }
  }
}
