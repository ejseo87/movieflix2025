import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieflix2025/models/movie_detail_model.dart';
import 'package:movieflix2025/models/movie_model.dart';

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String popular = "popular";
  static const String nowPlaying = "now-playing";
  static const String comingSoon = "coming-soon";

  static Future<List<MovieModel>> getPopularMovies() async {
    return getMovies(popular);
  }

  static Future<List<MovieModel>> getNowPlayingMovies() async {
    return getMovies(nowPlaying);
  }

  static Future<List<MovieModel>> getComingSoonMovies() async {
    return getMovies(comingSoon);
  }

  static Future<List<MovieModel>> getMovies(String sectionName) async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl/$popular');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      if (json case {'results': List movies}) {
        for (var movie in movies) {
          //print(movie);
          var movieInstance = MovieModel(
            id: movie['id'].toString(),
            title: movie['title'],
            posterPath: movie['poster_path'],
          );
          movieInstances.add(movieInstance);
        }
      } else {
        throw const FormatException("Unexpected JSON format");
      }
      print("movieInstances length = ${movieInstances.length}");
      return movieInstances;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getMovieById(String id) async {
    final url = Uri.parse('$baseUrl/movie?id=$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final movieDetail = jsonDecode(response.body);
      //print(movieDetail);
      print("${movieDetail['title']}, ${movieDetail['title'].runtimeType} ");
      print("${movieDetail['runtime']}, ${movieDetail['runtime'].runtimeType}");
      print(
          "${movieDetail['vote_average']}, ${movieDetail['vote_average'].runtimeType}");
      print(
          "${movieDetail['overview']}, ${movieDetail['overview'].runtimeType}");
      print("${movieDetail['genres']}, ${movieDetail['genres'].runtimeType}");

      List<GenreModel> gg = movieDetail['genres']
          .map<GenreModel>((genre) => GenreModel.fromJson(genre))
          .toList();
      for (var g in gg) {
        print(g.name);
      }

      var i = MovieDetailModel.fromJson(movieDetail);
      print(i.genres);
      print(i.title);
      print(i.runtime);
      print(i.voteAverage);
      print(i.overview);
      return MovieDetailModel.fromJson(movieDetail);
    }
    throw Error();
  }
}
