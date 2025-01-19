class MovieModel {
  final String id, title, posterPath;

  MovieModel({
    required this.id,
    required this.title,
    required this.posterPath,
  });

  MovieModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        posterPath = json['poster_path'].replaceAll(":", ";;"),
        id = json['id'];
}
