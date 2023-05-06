import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Core/Cache.dart';
import 'package:newsapp/Core/Themes.dart';
import 'package:newsapp/Core/DioHelper.dart';
import 'package:newsapp/Features/Home/Presentation/Manger/HomeCubit.dart';
import 'package:newsapp/Features/Home/Presentation/Manger/HomeStates.dart';
import 'package:newsapp/Features/Home/Presentation/HomeView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Cache.init();
  DioHelper.init();
  bool? isDark = Cache.getbool(key: 'isDark');
  runApp(HighNotesApp(
    isDark: isDark,
  ));
}

class HighNotesApp extends StatelessWidget {
  const HighNotesApp({super.key, required this.isDark});
  final bool? isDark;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..changeThemeState(fromShared: isDark)
        ..getData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: HomeCubit.getobject(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
            home: const HomeView(),
          );
        },
      ),
    );
  }
}
