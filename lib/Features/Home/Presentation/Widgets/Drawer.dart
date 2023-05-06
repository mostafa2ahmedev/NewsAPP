import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/Core/utils/widgets/VerticalSpacing.dart';
import 'package:newsapp/Features/Home/Presentation/BookMarkView.dart';
import 'package:newsapp/Features/Home/Presentation/Manger/HomeStates.dart';
import 'package:newsapp/Features/Home/Presentation/Widgets/CustomListTile.dart';
import 'package:page_transition/page_transition.dart';

import '../Manger/HomeCubit.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Drawer(
          // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListView(
              children: [
                DrawerHeader(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  child: Column(
                    children: [
                      Flexible(
                        child: Image.asset(
                          'assets/images/newspaper.png',
                          height: 60,
                          width: 60,
                        ),
                      ),
                      const VerticalSpacing(20),
                      Text(
                        'News app',
                        style: GoogleFonts.lobster(
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 20, letterSpacing: 0.6)),
                      ),
                    ],
                  ),
                ),
                const VerticalSpacing(20),
                CustomListTile(
                    lablel: 'Home', iconData: IconlyBold.home, ontap: () {}),
                CustomListTile(
                    lablel: 'Book Mark',
                    iconData: IconlyBold.bookmark,
                    ontap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const BookMarkView(),
                            inheritTheme: true,
                            ctx: context),
                      );
                    }),
                const Divider(
                  thickness: 5,
                  indent: 50,
                  endIndent: 50,
                  color: Colors.grey,
                ),
                SwitchListTile(
                  title: Text(
                      HomeCubit.getobject(context).isDark ? 'Dark' : 'Light',
                      style: Theme.of(context).textTheme.bodyMedium),
                  secondary: Icon(
                    HomeCubit.getobject(context).isDark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  value: HomeCubit.getobject(context).isDark,
                  onChanged: (v) {
                    HomeCubit.getobject(context).changeThemeState();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
