import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}



// const GradientText(
//   'EthPay',
//   style: TextStyle(
//     fontSize: 24,
//     fontWeight: FontWeight.w600,
//   ),
//   gradient: LinearGradient(
//     colors: [
//       Color(0xFF38B6FF),
//       Color(0xFF5271FF),
//     ],
//   ),
// ),