import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static Future<void> fetchMovies() async {
    final response = await http.get(
      Uri.parse('https://your-api-endpoint.com/movies'),
      headers: {
        'X-RapidAPI-Key': dotenv.env['RAPIDAPI_KEY']!,
        'X-RapidAPI-Host': dotenv.env['RAPIDAPI_HOST']!,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
    } else {
      print('Failed to fetch movies: ${response.statusCode}');
    }
  }
}
