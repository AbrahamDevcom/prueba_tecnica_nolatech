import 'package:flutter/material.dart';

import '../../utils/custom_colors.dart';

class BtnLike extends StatelessWidget {
  const BtnLike({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: primary, borderRadius: BorderRadius.circular(8)),
        ),
        Icon(
          Icons.favorite_border_rounded,
          color: white,
        ),
      ],
    );
  }
}
