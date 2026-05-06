class ApiConfig {
  static const String baseUrl = 'http://172.20.10.14:3000'; // Assuming port 3000, common for backends.
  static const String apiPath = '/api';

  static String get fullUrl => '$baseUrl$apiPath';
}
