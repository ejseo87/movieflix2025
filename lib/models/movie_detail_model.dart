class MovieDetailModel {
  final String title;
  final int runtime;
  final double voteAverage;
  final String overview;
  final List<GenreModel> genres;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        runtime = json['runtime'],
        voteAverage = json['vote_average'],
        overview = json['overview'],
        genres = json['genres']
            .map<GenreModel>((genre) => GenreModel.fromJson(genre))
            .toList();
}

class GenreModel {
  final String name;

  GenreModel.fromJson(Map<String, dynamic> json) : name = json['name'];
}
