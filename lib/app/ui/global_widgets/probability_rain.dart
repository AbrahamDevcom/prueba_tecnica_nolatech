import 'package:flutter/material.dart';
import 'package:prueba_tecnica_nolatech/app/utils/utils.dart';

class ProbabilityRain extends StatelessWidget {
  const ProbabilityRain({super.key, required this.percentage});
  final dynamic percentage;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset("assets/icons/lluvia.png"),
        Text("$percentage%"),
      ].divide(const SizedBox(width: 4)),
    );
  }
}
