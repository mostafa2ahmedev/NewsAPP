import 'package:flutter/material.dart';

class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing(this.hieght, {super.key});
  final double hieght;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hieght,
    );
  }
}

class HorizontalSpancing extends StatelessWidget {
  const HorizontalSpancing(this.width, {super.key});
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
