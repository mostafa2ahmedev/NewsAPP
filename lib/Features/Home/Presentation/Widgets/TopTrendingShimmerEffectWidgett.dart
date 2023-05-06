import 'package:flutter/material.dart';
import 'package:newsapp/Core/utils/utils.dart';
import 'package:newsapp/Features/Home/Presentation/Manger/HomeCubit.dart';
import 'package:shimmer/shimmer.dart';

class TopTrendingLoadingWidget extends StatelessWidget {
  const TopTrendingLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        // height: size.height * 0.45,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Shimmer.fromColors(
          baseColor: HomeCubit.getobject(context).isDark
              ? Colors.grey.shade500
              : Colors.grey.shade200,
          highlightColor: HomeCubit.getobject(context).isDark
              ? Colors.grey.shade700
              : Colors.grey.shade400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: Utils(context).getScreenSize.height * 0.33,
                  width: double.infinity,
                  color: HomeCubit.getobject(context).isDark
                      ? Colors.grey.shade600
                      : Colors.grey.shade100,
                ),
              ),
              // Title
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: Utils(context).getScreenSize.height * 0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: HomeCubit.getobject(context).isDark
                          ? Colors.grey.shade600
                          : Colors.grey.shade100,
                    ),
                  )),
              // Date
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: Utils(context).getScreenSize.height * 0.025,
                    width: Utils(context).getScreenSize.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: HomeCubit.getobject(context).isDark
                          ? Colors.grey.shade600
                          : Colors.grey.shade100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
