import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SliderInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SliderInfo(this.title, this.caption, this.imageUrl);
}


final slides = <SliderInfo>[
 SliderInfo('Busca la comida', 'Aliqua et consectetur ut cupidatat ipsum.', 'assets/images/1.png'),
 SliderInfo('Entrega rapida', 'Magna est dolore mollit Lorem aliqua aliquip consequat consequat consectetur commodo.', 'assets/images/2.png'),
 SliderInfo('Disfruta la comida', 'Voluptate Lorem do laboris Lorem qui.', 'assets/images/3.png'),
];

class AppTutorialScreen extends StatefulWidget {

  static const name = 'tutorial_screen';
  
  const AppTutorialScreen({super.key});

  @override
  State<AppTutorialScreen> createState() => _AppTutorialScreenState();
}

class _AppTutorialScreenState extends State<AppTutorialScreen> {

  final PageController pageViewController = PageController();
  bool endReached = false;

  @override
  void initState() {
    
    super.initState();

    pageViewController.addListener(() {
      final page = pageViewController.page ?? 0;
      if  ( !endReached && page >= (slides.length - 1.5) ){
        setState(() {
          endReached = true;
        });
      }
      // print('${ pageViewController.page }');
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: pageViewController,
            physics: const BouncingScrollPhysics(),
            children:slides.map(
              (slideData) => _Slide(
                title: slideData.title,
                caption: slideData.caption,
                imageUrl: slideData.imageUrl 
              )
            ).toList(),
          ),
          Positioned(
            right: 20,
            top: 50,
            child: TextButton(
              child: const Text('Salir'),
              onPressed: () => context.pop(),
            )
          ),
          endReached ?
          Positioned(
            right: 30,
            bottom: 30,
            child: FadeInRight(
              from: 15,
              delay: const Duration(seconds: 1),
              child: FilledButton(
                onPressed: () => context.pop(),
                child: const Text('Comenzar'),
              ),
            ),
          ): const SizedBox(),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final String title;
  final String caption;
  final String imageUrl;

  const _Slide({
    required this.title, 
    required this.caption,
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage( imageUrl )),
            const SizedBox(height: 20,),
            Text(title, style: titleStyle,),
            const SizedBox(height: 20,),
            Text(caption, style: captionStyle,),
          ],
        ),
      ),
    );
  }
}