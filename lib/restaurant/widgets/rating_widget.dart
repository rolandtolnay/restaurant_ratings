import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
    required this.ratingList,
  });

  final Iterable<int> ratingList;

  @override
  Widget build(BuildContext context) {
    final ratingAvg = ratingList.reduce((a, b) => a + b) / ratingList.length;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star, size: 14, color: Colors.amber),
        const SizedBox(width: 4),
        Text(ratingAvg.toStringAsFixed(1)),
        const SizedBox(width: 4),
        Text('(${ratingList.length})'),
      ],
    );
  }
}
