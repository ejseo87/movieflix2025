import 'package:flutter/material.dart';
import 'package:movieflix2025/models/movie_model.dart';
import 'package:movieflix2025/screen/detail_screen.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({
    super.key,
    required this.movie,
    required this.height,
    required this.width,
    required this.isShowingTitle,
  });

  final MovieModel movie;
  final double height, width;
  final bool isShowingTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: movie.title,
              posterPath: movie.posterPath,
              id: movie.id,
            ),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: height,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  offset: const Offset(10, 10),
                  color: Colors.black.withOpacity(0.3),
                ),
              ],
            ),
            child: Image.network(
              "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (isShowingTitle)
            SizedBox(
              width: width,
              child: Text(
                movie.title,
                textAlign: TextAlign.start,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
