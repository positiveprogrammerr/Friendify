import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final int maxRating;
  final IconData filledStar;
  final IconData unfilledStar;
  final Color? color;

  const StarRating({
    Key? key,
    required this.rating,
    this.maxRating = 5,
    this.filledStar = Icons.star,
    this.unfilledStar = Icons.star_border,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        if (index < rating) {
          return Icon(
            filledStar,
            color: color ?? Theme.of(context).primaryColor,
          );
        } 
        return const SizedBox();
      }),
    );
  }
}
