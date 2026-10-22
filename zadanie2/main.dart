import 'package:flutter/material.dart';

class RatingBadge extends StatelessWidget {
  final double rating;
  final String? label;

  const RatingBadge({super.key, required this.rating, this.label})
      : assert(rating >= 0.0 && rating <= 5.0);

  Color _ratingColor(BuildContext context) {
    if (rating >= 4.0) return Colors.green;
    if (rating >= 2.5) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final color = _ratingColor(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: color),
        const SizedBox(width: 4),
        Text(rating.toStringAsFixed(1), style: TextStyle(color: color)),
        if (label != null) ...[
          const SizedBox(width: 8),
          Text(label!),
        ],
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBadge(rating: 4.7, label: 'Відмінно'),
            SizedBox(height: 12),
            RatingBadge(rating: 1.2),
          ],
        ),
      ),
    ),
  ));
}
