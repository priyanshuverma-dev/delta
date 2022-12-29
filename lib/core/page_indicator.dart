import 'package:answer_it/utlts/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget pageIndicator(int length, PageController controller) {
  return SmoothPageIndicator(
    axisDirection: Axis.horizontal,
    textDirection: TextDirection.rtl,
    controller: controller,
    count: length,
    effect: ScrollingDotsEffect(
      activeStrokeWidth: 2.6,
      activeDotScale: 1.3,
      maxVisibleDots: 5,
      radius: 8,
      spacing: 8,
      dotHeight: 8,
      dotWidth: 8,
      dotColor: Colours.textColor,
      activeDotColor: Colours.primaryColor,
    ),
  );
}
