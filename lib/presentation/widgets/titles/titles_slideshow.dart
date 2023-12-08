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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Swiper(
              viewportFraction: 0.4,
              scale: 0.5,
              autoplay: false,
              itemCount: titles.length,
              pagination: SwiperPagination(
                margin: const EdgeInsets.only(top: 10),
                builder: DotSwiperPaginationBuilder(
                  activeColor: colors.primary,
                  color: colors.secondary
                )
              ),
              itemBuilder: (context, index) {
                final title = titles[index];
                return FadeInLeft(
                  duration: const Duration(milliseconds: 500),
                  child: _Slide(title: title),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatefulWidget {
  final Titles title;

  const _Slide({required this.title});

  @override
  State<_Slide> createState() => _SlideState();
}

class _SlideState extends State<_Slide> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      boxShadow: const [
        BoxShadow(
          color: Colors.black38,
          blurRadius: 10,
          offset: Offset(0, 10)
        )
      ]
    );
    return GestureDetector(
      onTap: () => context.push('/Reglament/${widget.title.idTitles}'),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedBox(
              decoration: decoration,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: SizedBox(
                  height: 300,
                  child: Image.network(
                    isLoading 
                    ? 'https://testcub1.s3.amazonaws.com/static/img/searching.gif'
                    : widget.title.coverName,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if(loadingProgress != null){
                        return const DecoratedBox(
                          decoration: BoxDecoration(color: Colors.black12),
                        );
                      }
                      return FadeIn(child: child);
                    },
                  ),
                )
              )
            ),
            const SizedBox(height: 20,),
            Text(
              widget.title.nameTitle, 
              maxLines: 2, 
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
