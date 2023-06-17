class Movie {
  final num id;
  final String title;
  final String backdropImagePath;
  final String posterImagePath;
  final String releaseDate;
  final List<num> genres;
  final String details;
  final String language;
  final num voteAvg;

  const Movie({
    required this.id,
    required this.title,
    required this.backdropImagePath,
    required this.posterImagePath,
    required this.releaseDate,
    required this.genres,
    required this.details,
    required this.language,
    required this.voteAvg,
  });
}
