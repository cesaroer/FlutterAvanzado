import 'package:flutter/material.dart';
import 'package:ingeniochallenge/helpers/helpers.dart';

class BiographyWidget extends StatelessWidget {
  final String text;
  const BiographyWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text.truncateTo(100),
        overflow: TextOverflow.ellipsis,
        maxLines: 10,
        softWrap: true,
      ),
    );
  }
}
