import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  final int ratingCount;
  const StarRatingWidget({required this.ratingCount, super.key});

  @override
  Widget build(BuildContext context) {
    final int unFilledStars = 5 - ratingCount;
    return Row(
      children: [
        ...List.generate(ratingCount, (index) =>
            const Icon(Icons.star, color: Colors.amber,),),

        ...List.generate(unFilledStars, (index) =>
            const Icon(Icons.star_border_outlined),)
      ],
    );
  }
}
