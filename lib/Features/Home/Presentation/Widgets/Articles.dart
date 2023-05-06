import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/Core/utils/utils.dart';
import 'package:newsapp/Core/utils/widgets/VerticalSpacing.dart';
import 'package:newsapp/Features/Home/Data/NewsModel.dart';
import 'package:newsapp/Features/Home/Presentation/BlogDetails.dart';
import 'package:newsapp/Features/Home/Presentation/NewsDeatailsWebView.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class Articles extends StatelessWidget {
  const Articles({super.key, required this.articlesModel});
  final ArticlesModel articlesModel;
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NewsDetailsScreen(
                articlesModel: articlesModel,
              );
            }));
          },
          child: Stack(
            children: [
              Container(
                color: Theme.of(context).colorScheme.secondary,
                height: 60,
                width: 60,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  color: Theme.of(context).colorScheme.secondary,
                  height: 60,
                  width: 60,
                ),
              ),
              Container(
                color: Theme.of(context).cardColor,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Hero(
                        tag: articlesModel.publishedAt!,
                        child: FancyShimmerImage(
                            shimmerDirection: ShimmerDirection.btt,
                            height: size.height * 0.12,
                            width: size.height * 0.12,
                            boxFit: BoxFit.fill,
                            errorWidget:
                                Image.asset('assets/images/empty_image.png'),
                            imageUrl: articlesModel.urlToImage!),
                      ),
                    ),
                    const HorizontalSpancing(10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            articlesModel.title!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.montserrat(fontSize: 15),
                          ),
                          const VerticalSpacing(5),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              '🧭 ${articlesModel.readingTimeText}',
                              style: GoogleFonts.montserrat(fontSize: 15),
                            ),
                          ),
                          FittedBox(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: NewsDetailsWebView(
                                              url: articlesModel.url!),
                                          inheritTheme: true,
                                          ctx: context),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.link,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  articlesModel.dataToShow!,
                                  maxLines: 1,
                                  style: GoogleFonts.montserrat(fontSize: 15),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
