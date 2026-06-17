import 'package:flutter/material.dart';

class ChlnDetailsText extends StatelessWidget {
  final String title;
  final String content;
  const ChlnDetailsText(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        Text(
          content,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
