import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../credentials/credentials.dart';

class ApiUtilities {
  static Future<dynamic> getUpcommingMoviesData() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=${Credentials.apiKey}');
    var response = await http.get(url);

    var jsonResponse = convert.jsonDecode(response.body);

    if (response.statusCode == 200) {
      print('Request passed with status: ${response.statusCode}.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load movies');
    }

    return jsonResponse;
  }

  static Future<dynamic> getMovieDataById(String movieId) async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/${movieId}?api_key=${Credentials.apiKey}');
    var response = await http.get(url);

    var jsonResponse = convert.jsonDecode(response.body);

    if (response.statusCode == 200) {
      print('Request passed with status: ${response.statusCode}.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return jsonResponse;
  }

  static Future<dynamic> getMovieImageDataById(String movieId) async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/${movieId}/images?api_key=${Credentials.apiKey}');
    var response = await http.get(url);

    var jsonResponse = convert.jsonDecode(response.body);

    if (response.statusCode == 200) {
      print('Request passed with status: ${response.statusCode}.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return jsonResponse;
  }

  static Future<dynamic> getMovieGeresMap() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/genre/movie/list?api_key=${Credentials.apiKey}&language=en-US');
    var response = await http.get(url);

    var jsonResponse = convert.jsonDecode(response.body);

    if (response.statusCode == 200) {
      print('Request passed with status: ${response.statusCode}.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load genres');
    }

    return jsonResponse;
  }

  static String getNetworkImageCompletePath(String imageName) {
    return 'https://image.tmdb.org/t/p/w500/${imageName}';
  }
}
