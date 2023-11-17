import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/reglaments.dart';

import 'reglaments.dart';
class ChapterWidget extends StatelessWidget {
  const ChapterWidget({
    super.key, 
    required this.chapter,
    required this.colors,
    required this.hashCode,
    required this.isLogged,
  });

  final Chapter chapter;
  final ColorScheme colors;
    // ignore: invalid_override_of_non_virtual_member, hash_and_equals, annotate_overrides
  final int hashCode;
  final AsyncValue<bool> isLogged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 40),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12.0),
              Hero(
                tag: 'chapter_title_$hashCode',
                child: Text(
                  chapter.nameChapter,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    letterSpacing: 1.2,
                    color: colors.onBackground,
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              ...chapter.sections.map((section) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'section_title_${section.hashCode}',
                      child: Text(
                        section.nameSection,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          letterSpacing: 1.1,
                          color: colors.onBackground,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    ...section.articles.map((article) {
                      return ArticleWidget(hashCode: hashCode, colors: colors, isLogged: isLogged, article: article,);
                    }).toList(),
                  ],
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }
}