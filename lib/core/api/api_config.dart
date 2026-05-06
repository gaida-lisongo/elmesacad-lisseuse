class ApiConfig {
  static const String baseUrl = 'http://localhost:8000'; // Assuming port 3000, common for backends.
  static const String apiPath = '/api';

  static String get fullUrl => '$baseUrl$apiPath';
}
