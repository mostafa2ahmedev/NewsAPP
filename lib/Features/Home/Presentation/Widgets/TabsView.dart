import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabsView extends StatelessWidget {
  const TabsView(
      {super.key,
      required this.ontap,
      required this.text,
      required this.fontsize,
      required this.color});
  final VoidCallback ontap;
  final String text;
  final double fontsize;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: color),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            text,
            style: TextStyle(fontSize: fontsize, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
