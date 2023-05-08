import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/Features/Home/Presentation/Widgets/EmptyNewsView.dart';

class BookMarkView extends StatelessWidget {
  const BookMarkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            'BookMarks',
            style: GoogleFonts.lobster(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 20, letterSpacing: 0.6)),
          ),
        ),
        body: const EmptyNewsView(
            text: 'You didn\'t add anything yet to your bookmark',
            imageUrl: 'assets/images/bookmark.png')
        // body: ListView.builder(
        //     itemCount: 20,
        //     itemBuilder: (ctx, index) {
        //       return const Articles();
        //     }),
        );
  }
}
