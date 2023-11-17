import 'package:flutter/material.dart';

class FooterButtons extends StatelessWidget {
  const FooterButtons({
    super.key, 
    required bool canGoBack,
    required this.colors,
    required PageController pageController,
    required bool canGoForward,
  }) : _canGoBack = canGoBack, _pageController = pageController, _canGoForward = canGoForward;

  final bool _canGoBack;
  final ColorScheme colors;
  final PageController _pageController;
  final bool _canGoForward;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: _canGoBack ? colors.onBackground : colors.onSurface.withOpacity(0.5)),
              onPressed: _canGoBack
                  ? () {
                      _pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                    }
                  : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: _canGoForward ? colors.onBackground : colors.onSurface.withOpacity(0.5)),
              onPressed: _canGoForward
                  ? () {
                      _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}