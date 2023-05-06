import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Features/Home/Presentation/Manger/Enum.dart';
import 'package:newsapp/Features/Home/Presentation/Manger/HomeCubit.dart';
import 'package:newsapp/Features/Home/Presentation/Manger/HomeStates.dart';
import 'package:newsapp/Features/Home/Presentation/Widgets/ArticlesShimmerEffectWidgett.dart';
import 'package:newsapp/Features/Home/Presentation/Widgets/TopTrendingShimmerEffectWidgett.dart';

import '../../../../Core/utils/utils.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return HomeCubit.getobject(context).enumMode == NewsType.topTrending
            ? SizedBox(
                height: Utils(context).getScreenSize.height * 0.6,
                child: Swiper(
                  viewportFraction: 0.9,
                  autoplay: true,
                  autoplayDelay: 8000,
                  itemWidth: Utils(context).getScreenSize.width * 0.9,
                  layout: SwiperLayout.STACK,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const TopTrendingLoadingWidget();
                  },
                ),
              )
            : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const ArticlesShimmerEffectWidget();
                  },
                ),
              );
      },
    );
  }
}
