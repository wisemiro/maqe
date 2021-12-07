import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TitleText extends StatelessWidget {
  final String inputText;
  final Color color;
  final double size;
  final FontWeight? fontWeight;
  final TextOverflow? flow;
  const TitleText({
    required this.inputText,
    required this.color,
    required this.size,
     this.fontWeight,
    this.flow,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      inputText,
      minFontSize: 16,
      stepGranularity: 1,
      maxLines: 2,
      overflow: flow,
      style: TextStyle(
        color: color,
        letterSpacing: 0.8,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SubTitleText extends StatelessWidget {
  final String inputText;
  final Color color;
  final double size;
  final FontWeight? fontWeight;
  final TextOverflow? flow;
  const SubTitleText({
    required this.inputText,
    required this.color,
    required this.size,
     this.fontWeight,
    this.flow,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      inputText,
      minFontSize: 14,
      stepGranularity: 1,
      maxLines: 3,
      overflow: flow,
      style: TextStyle(
          color: color,
          letterSpacing: 1.0,
          fontSize: size,
          fontWeight: fontWeight),
    );
  }
}

class RegularText extends StatelessWidget {
  final String inputText;
  final Color color;
  final double size;
  final FontWeight? fontWeight;
  const RegularText({
    required this.inputText,
    required this.color,
    required this.size,
     this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      inputText,
      minFontSize: 12,
      stepGranularity: 1,
      maxLines: 2,
      style: TextStyle(
        color: color,
        letterSpacing: 0.5,
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );
  }
}
