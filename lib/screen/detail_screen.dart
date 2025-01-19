import 'package:flutter/material.dart';
import 'package:movieflix2025/models/movie_detail_model.dart';
import 'package:movieflix2025/services/api_service.dart';
import 'package:movieflix2025/widgets/draw_stars.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final String title, posterPath, id;
  const DetailScreen({
    super.key,
    required this.title,
    required this.posterPath,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movie;

  @override
  void initState() {
    super.initState();
    movie = ApiService.getMovieById(widget.id);
  }

  void onButtonTap() async {
    final url = Uri.parse("https://www.cgv.co.kr/");
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.network(
              "https://image.tmdb.org/t/p/w500/${widget.posterPath}",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const Text(
                  "Back to list",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 300,
            left: 10,
            child: FutureBuilder(
              future: movie,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(3, 3),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                      DrawStars(voteAverage: snapshot.data!.voteAverage),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "${snapshot.data!.runtime ~/ 60}h ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              shadows: const [
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(2, 2),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${snapshot.data!.runtime % 60}min | ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              shadows: const [
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(2, 2),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                          for (var i = 0; i < snapshot.data!.genres.length; i++)
                            i == snapshot.data!.genres.length - 1
                                ? Text(
                                    snapshot.data!.genres[i].name,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      shadows: const [
                                        Shadow(
                                          color: Colors.black,
                                          offset: Offset(2, 2),
                                          blurRadius: 3,
                                        ),
                                      ],
                                    ),
                                  )
                                : Text(
                                    "${snapshot.data!.genres[i].name}, ",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      shadows: const [
                                        Shadow(
                                          color: Colors.black,
                                          offset: Offset(2, 2),
                                          blurRadius: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      const Text(
                        "Storyline",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(3, 3),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 400,
                        width: MediaQuery.of(context).size.width - 20,
                        child: Text(
                          snapshot.data!.overview,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(2, 2),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return const Center(
                  child: Text("..."),
                );
              },
            ),
          ),
          Positioned(
            bottom: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                GestureDetector(
                  onTap: onButtonTap,
                  child: SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        "Buy ticket",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
