import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/custom_colors.dart';
import '../pages/reservation/controller/reservation_controller.dart';

class BtnBack extends StatelessWidget {
  const BtnBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final ctr = Provider.of<ReservationController>(context, listen: false);
        ctr.dispose();
        Navigator.pop(context);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: primary, borderRadius: BorderRadius.circular(8)),
          ),
          // ignore: prefer_const_constructors
          Icon(
            Icons.arrow_back_ios_new_rounded,
            color: white,
          ),
        ],
      ),
    );
  }
}
