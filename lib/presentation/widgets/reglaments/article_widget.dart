import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_library/domain/entities/reglaments.dart';
import 'package:in_library/domain/entities/select_user.dart';
import 'package:in_library/presentation/providers/add_favorites/add_favorites_provider.dart';
import 'package:in_library/presentation/widgets/reglaments/reglaments.dart';

class ArticleWidget extends ConsumerStatefulWidget {
  const ArticleWidget({
    super.key, 
    required this.hashCode,
    required this.colors,
    required this.isLogged,
    required this.article,
    this.user
  });

  // ignore: invalid_override_of_non_virtual_member, hash_and_equals, annotate_overrides
  final int hashCode;
  final Article article;
  final ColorScheme colors;
  final AsyncValue<bool> isLogged;
  final List<SelectUser>? user;

  @override
  ConsumerState<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends ConsumerState<ArticleWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: 'article_title_${widget.article.hashCode}',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.article.nameArticle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: widget.colors.onBackground,
                ),
              ),
              
                widget.isLogged.when(
                  data: (data) => data,
                  loading: () => false,
                  error: (error, stackTrace) => false,
                )
                ? IconButton(
                  onPressed: () {
                    ref.read(toggleFavorites.notifier).fetchToggleFavorites('${widget.article.idArticle}', '${widget.user![0].idUser}');
                  }, 
                  icon: const Icon(Icons.star_border_outlined
                  )
                )
                : const SizedBox(height: 0,),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        ...widget.article.paragraphs.map((paragraph) {
          return ParagraphWidget(colors: widget.colors, paragraph: paragraph,);
        }).toList(),
      ],
    );
  }
}