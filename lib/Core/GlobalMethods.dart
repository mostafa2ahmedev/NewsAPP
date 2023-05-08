import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/Core/utils/widgets/VerticalSpacing.dart';

class GlobalMethods {
  static String formattedDate(String publishedAt) {
    var d = DateTime.now();
    DateTime parsedDate = DateTime.parse(publishedAt);
    var formatteDate = DateFormat('yyyy-mm-dd hh:mm:ss').format(parsedDate);
    var publishedDate = DateFormat('yyyy-mm-dd hh:mm:ss').parse(formatteDate);
    return '${publishedDate.day}/${publishedDate.month}/${publishedDate.year} On ${publishedDate.hour}:${publishedDate.minute}:${publishedDate.second}';
  }

  static Future<void> alertDialog(
      {required String errMessage, required BuildContext context}) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(errMessage),
            title: Row(
              children: const [
                Icon(
                  IconlyBold.danger,
                  color: Colors.red,
                ),
                HorizontalSpancing(10),
                Text('An error occured')
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }
}
