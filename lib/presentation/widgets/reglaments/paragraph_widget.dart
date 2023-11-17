import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:in_library/domain/entities/reglaments.dart';

class ParagraphWidget extends StatelessWidget {

  final Paragraph paragraph;
  final ColorScheme colors;

  const ParagraphWidget({
    super.key, 
    required this.colors,
    required this.paragraph,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: colors.surface,
        ),
        child: Column(
          children: [
            Text(
              paragraph.paragraph,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16.0, color: colors.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}