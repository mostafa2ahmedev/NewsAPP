import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Core/utils/utils.dart';
import 'package:newsapp/Core/utils/widgets/VerticalSpacing.dart';
import 'package:newsapp/Features/Home/Presentation/Manger/HomeCubit.dart';
import 'package:newsapp/Features/Home/Presentation/Manger/HomeStates.dart';
import 'package:shimmer/shimmer.dart';

class ArticlesShimmerEffectWidget extends StatelessWidget {
  const ArticlesShimmerEffectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.getobject(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: Theme.of(context).cardColor,
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
                  child: Shimmer.fromColors(
                    baseColor: cubit.isDark
                        ? Colors.grey.shade500
                        : Colors.grey.shade200,
                    highlightColor: cubit.isDark
                        ? Colors.grey.shade700
                        : Colors.grey.shade400,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: cubit.isDark
                                ? Colors.grey.shade600
                                : Colors.grey.shade100,
                            height: size.height * 0.12,
                            width: size.height * 0.12,
                          ),
                        ),
                        const HorizontalSpancing(10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: size.height * 0.06,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: cubit.isDark
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade100,
                                ),
                              ),
                              const VerticalSpacing(5),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: size.width * 0.4,
                                  height: size.height * 0.025,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: cubit.isDark
                                        ? Colors.grey.shade600
                                        : Colors.grey.shade100,
                                  ),
                                ),
                              ),
                              FittedBox(
                                child: Row(
                                  children: [
                                    ClipOval(
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        color: cubit.isDark
                                            ? Colors.grey.shade600
                                            : Colors.grey.shade100,
                                      ),
                                    ),
                                    const HorizontalSpancing(5),
                                    Container(
                                      width: size.width * 0.4,
                                      height: size.height * 0.025,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: cubit.isDark
                                            ? Colors.grey.shade600
                                            : Colors.grey.shade100,
                                      ),
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
