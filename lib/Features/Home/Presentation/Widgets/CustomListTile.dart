import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.lablel,
      required this.iconData,
      required this.ontap});
  final String lablel;
  final IconData iconData;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        lablel,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
      ),
      leading: Icon(
        iconData,
        color: Theme.of(context).iconTheme.color,
      ),
      onTap: ontap,
    );
  }
}
