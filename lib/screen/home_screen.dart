import 'package:flutter/material.dart';
import 'package:movieflix2025/models/movie_model.dart';
import 'package:movieflix2025/services/api_service.dart';
import 'package:movieflix2025/widgets/movie_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieModel>> popularMovies = ApiService.getPopularMovies();
  final Future<List<MovieModel>> nowPlayingMovies =
      ApiService.getNowPlayingMovies();
  final Future<List<MovieModel>> comingSoonMovies =
      ApiService.getComingSoonMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            makeList(
              sectionMovies: popularMovies,
              sectionTitle: "Popular Movies",
              width: 300,
              height: 200,
              isShowingTitle: false,
            ),
            makeList(
              sectionMovies: nowPlayingMovies,
              sectionTitle: "Now in Cinemas",
              width: 150,
              height: 150,
              isShowingTitle: true,
            ),
            makeList(
              sectionMovies: comingSoonMovies,
              sectionTitle: "Coming soon",
              width: 150,
              height: 140,
              isShowingTitle: true,
            ),
            /* FutureBuilder(
              future: commingSoonMovies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "Coming Soon",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 150,
                        child: makeLiskt(
                            snapshot: snapshot,
                            width: 100,
                            height: 100,
                            isShowTitle: true),
                      ),
                    ],
                  );
                }

                return const Text("...");
              },
            ),
            FutureBuilder(
              future: nowPlayingMovies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "Now in Cinemas",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 150,
                        child: makeLiskt(
                            snapshot: snapshot,
                            width: 100,
                            height: 100,
                            isShowTitle: true),
                      ),
                    ],
                  );
                }

                return const Text("...");
              },
            ), */
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<MovieModel>> makeList({
    required Future<List<MovieModel>> sectionMovies,
    required String sectionTitle,
    required double width,
    required double height,
    required bool isShowingTitle,
  }) {
    return FutureBuilder(
      future: sectionMovies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                sectionTitle,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: isShowingTitle ? height + 60 : height + 20,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 15),
                  itemBuilder: (context, index) {
                    MovieModel movie = snapshot.data![index];
                    return MovieTile(
                      movie: movie,
                      width: width,
                      height: height,
                      isShowingTitle: isShowingTitle,
                    );
                  },
                ),
              ),
            ],
          );
        }

        return const Text("...");
      },
    );
  }
}
