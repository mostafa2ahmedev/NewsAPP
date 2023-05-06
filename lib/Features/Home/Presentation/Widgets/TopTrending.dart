import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/Core/utils/utils.dart';
import 'package:newsapp/Features/Home/Data/NewsModel.dart';
import 'package:newsapp/Features/Home/Presentation/BlogDetails.dart';
import 'package:page_transition/page_transition.dart';

import '../NewsDeatailsWebView.dart';

class TopTrending extends StatelessWidget {
  const TopTrending({Key? key, required this.articlesModel}) : super(key: key);
  final ArticlesModel articlesModel;
  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) =>
                        NewsDetailsScreen(articlesModel: articlesModel))));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  boxFit: BoxFit.fill,
                  errorWidget: Image.asset('assets/images/empty_image.png'),
                  imageUrl: articlesModel.urlToImage!,
                  height: size.height * 0.33,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  articlesModel.title!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: NewsDetailsWebView(
                              url: articlesModel.url!,
                            ),
                            inheritTheme: true,
                            ctx: context),
                      );
                    },
                    icon: const Icon(
                      Icons.link,
                    ),
                  ),
                  const Spacer(),
                  SelectableText(
                    articlesModel.dataToShow!,
                    style: GoogleFonts.montserrat(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
