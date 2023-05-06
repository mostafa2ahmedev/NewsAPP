import 'package:flutter/material.dart';
import 'package:newsapp/Features/Home/Presentation/Manger/HomeCubit.dart';

class EmptyNewsView extends StatelessWidget {
  const EmptyNewsView({super.key, required this.text, required this.imageUrl});
  final String text;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(imageUrl),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: HomeCubit.getobject(context).isDark
                    ? Colors.white
                    : Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
