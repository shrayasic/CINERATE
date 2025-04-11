// lib/services/imdb_api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../utils/api_constants.dart';

class ImdbApiService {
  static Future<List<Movie>> fetchMostPopularMovies() async {
    final url = Uri.parse('https://${ApiConstants.apiHost}/imdb/most-popular-movies');
    final headers = {
      'x-rapidapi-key': ApiConstants.apiKey,
      'x-rapidapi-host': ApiConstants.apiHost,
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      // Explicitly cast each dynamic object to Movie
      return jsonData.map((movie) => Movie.fromJson(movie)).toList().cast<Movie>();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}


class Movie {
  final String? id;
  final String? primaryImage;

  Movie({required this.id, required this.primaryImage});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as String?,
      primaryImage: json['primaryImage'] as String?,
    );
  }
}


