import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static final String apiKey = dotenv.env['RAPIDAPI_KEY']!;
  static final String apiHost = dotenv.env['RAPIDAPI_HOST']!;

  static void printApiKeys() {
    print('API Key: $apiKey');
    print('API Host: $apiHost');
  }
}
