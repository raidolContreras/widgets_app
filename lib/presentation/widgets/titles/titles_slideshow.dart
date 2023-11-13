import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_library/domain/entities/titles.dart';

class TitlesSlideshow extends StatelessWidget {
  final List<Titles> titles;

  const TitlesSlideshow({
    super.key,
    required this.titles
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Swiper(
                viewportFraction: 0.3,
                scale: 0.6,
                autoplay: true,
                autoplayDelay: 5000,
                itemCount: titles.length,
                pagination: SwiperPagination(
                  margin: const EdgeInsets.only(top: 0),
                  builder: DotSwiperPaginationBuilder(
                    activeColor: colors.primary,
                    color: colors.secondary
                  )
                ),
                itemBuilder: (context, index) {
                  final title = titles[index];
                  return FadeInLeft(
                    duration: Duration(milliseconds: 500),
                    child: _Slide(title: title),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Titles title;

  const _Slide({required this.title});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black38,
          blurRadius: 10,
          offset: Offset(0, 10)
        )
      ]
    );
    return GestureDetector(
      onTap: () => context.push('/Reglament/${title.idTitles}'),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            DecoratedBox(
              decoration: decoration,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  title.coverName,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if(loadingProgress != null){
                      return const DecoratedBox(
                        decoration: BoxDecoration(color: Colors.black12),
                      );
                    }
                    return FadeIn(child: child);
                  },
                )
              )
            ),
            const SizedBox(height: 20,),
            Text(
              title.nameTitle, 
              maxLines: 1, 
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colors.primary,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
