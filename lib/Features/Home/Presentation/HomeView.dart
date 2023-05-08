import 'package:card_swiper/card_swiper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/Core/utils/utils.dart';
import 'package:newsapp/Features/Home/Presentation/Manger/HomeCubit.dart';
import 'package:newsapp/Features/Home/Presentation/Manger/HomeStates.dart';
import 'package:newsapp/Features/Home/Presentation/Widgets/Articles.dart';
import 'package:newsapp/Features/Home/Presentation/Widgets/EmptyNewsView.dart';
import 'package:newsapp/Features/Home/Presentation/Widgets/LoadingWidget.dart';
import 'package:newsapp/Features/Home/Presentation/Widgets/PaginationButton.dart';
import 'package:newsapp/Features/Home/Presentation/Widgets/TabsView.dart';
import 'package:newsapp/Features/Home/Presentation/Manger/Enum.dart';

import '../../../Core/utils/widgets/VerticalSpacing.dart';

import 'Widgets/Drawer.dart';
import 'Widgets/TopTrending.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.getobject(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Text(
              'News app',
              style: GoogleFonts.lobster(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 20, letterSpacing: 0.6)),
            ),
          ),
          drawer: const DrawerView(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    TabsView(
                        ontap: () {
                          cubit.changeToTrendingEnumMode();
                        },
                        text: 'All News',
                        fontsize: cubit.enumMode == NewsType.allNews ? 22 : 14,
                        color: cubit.enumMode == NewsType.allNews
                            ? Theme.of(context).cardColor
                            : Colors.transparent),
                    const SizedBox(width: 20),
                    TabsView(
                        ontap: () {
                          cubit.changeToAllNewsEnumMode();
                        },
                        text: 'All Trending',
                        fontsize:
                            cubit.enumMode == NewsType.topTrending ? 22 : 14,
                        color: cubit.enumMode == NewsType.topTrending
                            ? Theme.of(context).cardColor
                            : Colors.transparent),
                  ],
                ),
                const VerticalSpacing(10),
                cubit.enumMode == NewsType.allNews
                    ? SizedBox(
                        height: kBottomNavigationBarHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PaginationButton(
                              text: 'Prev',
                              ontap: () {
                                if (cubit.currentIndex == 0) {
                                  return;
                                }
                                cubit.currentIndex -= 1;
                                cubit.changeIndex();
                              },
                            ),
                            Flexible(
                              child: ListView.builder(
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: ((context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Material(
                                      color: cubit.currentIndex == index
                                          ? Colors.blue
                                          : Theme.of(context).cardColor,
                                      child: InkWell(
                                        onTap: () {
                                          cubit.currentIndex = index;
                                          cubit.changeIndex();
                                        },
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('${index + 1}'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            PaginationButton(
                              text: 'Next',
                              ontap: () {
                                if (cubit.currentIndex == 4) {
                                  return;
                                }
                                cubit.currentIndex += 1;
                                cubit.changeIndex();
                              },
                            ),
                          ],
                        ),
                      )
                    : Container(),
                const VerticalSpacing(10),
                cubit.enumMode == NewsType.allNews
                    ? Align(
                        alignment: Alignment.topRight,
                        child: Material(
                          color: Theme.of(context).cardColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton(
                                value: cubit.eunmSort,
                                items: [
                                  DropdownMenuItem(
                                    value: SortByEnum.relevancy.name,
                                    child: Text(SortByEnum.relevancy.name),
                                  ),
                                  DropdownMenuItem(
                                    value: SortByEnum.publishedAt.name,
                                    child: Text(SortByEnum.publishedAt.name),
                                  ),
                                  DropdownMenuItem(
                                    value: SortByEnum.popularity.name,
                                    child: Text(SortByEnum.popularity.name),
                                  ),
                                ],
                                onChanged: (String? value) {
                                  cubit.eunmSort = value!;
                                  cubit.getData(
                                      page: cubit.currentIndex + 1,
                                      sortby: cubit.eunmSort);
                                }),
                          ),
                        ),
                      )
                    : Container(),
                if (cubit.enumMode == NewsType.allNews)
                  state is HomeDataFailer
                      ? Expanded(
                          child: EmptyNewsView(
                              text: state.errormessage,
                              imageUrl: 'assets/images/no_news.png'),
                        )
                      : ConditionalBuilder(
                          condition: cubit.articlees != null,
                          fallback: (context) => const LoadingWidget(),
                          builder: (context) {
                            return Expanded(
                              child: ListView.builder(
                                itemCount: cubit.articlees!.length,
                                itemBuilder: (ctx, index) {
                                  return Articles(
                                    articlesModel: cubit.articlees![index],
                                  );
                                },
                              ),
                            );
                          },
                        ),

                if (cubit.enumMode == NewsType.topTrending)
                  state is HomeDataFailer
                      ? Expanded(
                          child: EmptyNewsView(
                              text: state.errormessage,
                              imageUrl: 'assets/images/no_news.png'),
                        )
                      : ConditionalBuilder(
                          condition: cubit.topHeadline != null,
                          fallback: (context) => const LoadingWidget(),
                          builder: (context) {
                            return SizedBox(
                              height: Utils(context).getScreenSize.height * 0.6,
                              child: Swiper(
                                autoplayDelay: 8000,
                                autoplay: true,
                                itemWidth:
                                    Utils(context).getScreenSize.width * 0.9,
                                layout: SwiperLayout.STACK,
                                viewportFraction: 0.9,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return TopTrending(
                                    articlesModel: cubit.topHeadline![index],
                                  );
                                },
                              ),
                            );
                          },
                        ),

                // const LoadingWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
