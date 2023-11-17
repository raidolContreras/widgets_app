import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/reglaments.dart';
import 'package:in_library/presentation/widgets/reglaments/reglaments.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({
    super.key, 
    required this.hashCode,
    required this.colors,
    required this.isLogged, required this.article,
  });

  // ignore: invalid_override_of_non_virtual_member, hash_and_equals, annotate_overrides
  final int hashCode;
  final Article article;
  final ColorScheme colors;
  final AsyncValue<bool> isLogged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: 'article_title_${article.hashCode}',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                article.nameArticle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: colors.onBackground,
                ),
              ),
              
                isLogged.when(
                  data: (data) => data,
                  loading: () => false,
                  error: (error, stackTrace) => false,
                )
                ? IconButton(
                  onPressed: () {
                  }, 
                  icon: const Icon(Icons.star_border_outlined
                  )
                )
                : const SizedBox(height: 0,),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        ...article.paragraphs.map((paragraph) {
          return ParagraphWidget(colors: colors, paragraph: paragraph,);
        }).toList(),
      ],
    );
  }
}