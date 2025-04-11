import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../utils/api_constants.dart';
import '../../models/movie.dart';

class MoviedetailsService {
  final String baseUrl = 'https://imdb236.p.rapidapi.com/imdb';

  Future<Movie?> getMovieDetails(String movieId) async {
    try {
      final url = Uri.parse('$baseUrl/$movieId');

      final response = await http.get(
        url,
        headers: {
          'x-rapidapi-key': ApiConstants.apiKey,
          'x-rapidapi-host': ApiConstants.apiHost,
        },
      );

      if (response.statusCode == 200) {
        try {
          final decodedData = json.decode(response.body);

          // Handle releaseDate when it's a string
          if (decodedData['releaseDate'] is String) {
            final dateParts = decodedData['releaseDate'].split('-');
            if (dateParts.length == 3) {
              decodedData['releaseDate'] = {
                'year': int.tryParse(dateParts[0]),
                'month': int.tryParse(dateParts[1]),
                'day': int.tryParse(dateParts[2])
              };
            } else {
              decodedData['releaseDate'] = null;
            }
          }

          // Ensure externalLinks is properly handled
          if (decodedData['externalLinks'] == null) {
            decodedData['externalLinks'] = [];
          }

          // Ensure genres is properly handled
          if (decodedData['genres'] != null) {
            // Make sure it's a list of strings
            if (decodedData['genres'] is List) {
              decodedData['genres'] = (decodedData['genres'] as List).map((e) => e.toString()).toList();
            }
          } else {
            decodedData['genres'] = [];
          }

          // Ensure averageRating and numVotes are properly handled
          if (decodedData['averageRating'] == null) {
            decodedData['averageRating'] = 0.0;
          } else if (decodedData['averageRating'] is int) {
            decodedData['averageRating'] = (decodedData['averageRating'] as int).toDouble();
          }

          if (decodedData['numVotes'] == null) {
            decodedData['numVotes'] = 0;
          }

          // Handle productionCompanies if present but not needed in model
          if (decodedData.containsKey('productionCompanies')) {
            // We could extract company names here if needed
            // For now, ensure it doesn't break parsing
          }

          // Debug print for monitoring
          print('Processed data: ${decodedData['averageRating']}, ${decodedData['genres']}, ${decodedData['numVotes']}');

          return Movie.fromJson(decodedData);
        } catch (e) {
          print('Error decoding JSON: $e');
          print('Response body: ${response.body}');
          return null;
        }
      } else {
        print('Failed to load movie details. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error fetching movie details: $e');
      return null;
    }
  }
}