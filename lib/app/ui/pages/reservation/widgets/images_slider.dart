import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../utils/custom_colors.dart';
import '../../../global_widgets/button_back.dart';
import '../../../global_widgets/button_like.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
    required this.ctr,
  });

  final PageController ctr;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(children: [
        PageView(
          controller: ctr,
          children: List.generate(
            3,
            (index) => SizedBox.expand(
                child: Image.asset(
              "assets/header_court_${index + 1}.jpg",
              fit: BoxFit.cover,
            )),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0, 0.65),
          child: SmoothPageIndicator(
            controller: ctr,
            count: 3,
            axisDirection: Axis.horizontal,
            onDotClicked: (i) {
              ctr.animateToPage(
                i,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
            effect: const ExpandingDotsEffect(
              expansionFactor: 2,
              spacing: 8,
              radius: 16,
              dotWidth: 10,
              dotHeight: 10,
              dotColor: white,
              activeDotColor: primary,
              paintStyle: PaintingStyle.fill,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BtnBack(),
              BtnLike(),
            ],
          ),
        )
      ]),
    );
  }
}
