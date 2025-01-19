import 'package:flutter/material.dart';

class DrawStars extends StatelessWidget {
  final double voteAverage;
  const DrawStars({
    super.key,
    required this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 1; i <= voteAverage ~/ 2; i++)
          const Icon(
            Icons.star,
            color: Colors.yellow,
            size: 24,
            shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(3, 3),
                blurRadius: 5,
              )
            ],
          ),
        Icon(
          (voteAverage % 2) == 0 ? Icons.star_border_outlined : Icons.star_half,
          color: Colors.yellow,
          size: 24,
          shadows: const [
            Shadow(
              color: Colors.black,
              offset: Offset(3, 3),
              blurRadius: 5,
            )
          ],
        ),
      ],
    );
  }
}
