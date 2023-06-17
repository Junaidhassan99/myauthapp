import 'package:myauthapp/models/movie.dart';

class GeneralUtitities {
  static List<Movie> convertUpcommingMoviesDataToMovieList(dynamic jsonData) {
    // print(jsonData['results'][0]['original_title']);

    return (jsonData['results'] as List<dynamic>).map((e) {
      return Movie(
        id: e['id'],
        title: e['original_title'],
        backdropImagePath: e['backdrop_path'],
        posterImagePath: e['poster_path'],
        releaseDate: e['release_date'],
        genres: e['genre_ids'].cast<num>(),
        details: e['overview'],
        language: e['original_language'],
        voteAvg: e['vote_average'],
      );
    }).toList();
  }

  static Map<num, String> convertMovieGeresMapToSimpleMap(dynamic jsonData) {
    Map<num, String> genresMap = {};
    (jsonData['genres'] as List<dynamic>).forEach((e) {
      // return MapEntry(e['id'] as num, e['name'] as String);
      genresMap[e['id']] = e['name'];
    });

    return genresMap;
  }
}
