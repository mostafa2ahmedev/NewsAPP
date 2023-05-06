import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Core/Cache.dart';
import 'package:newsapp/Core/DioHelper.dart';
import 'package:newsapp/Features/Home/Data/NewsModel.dart';
import 'package:newsapp/Features/Home/Presentation/Manger/Enum.dart';

import 'HomeStates.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit getobject(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeThemeState({@required bool? fromShared}) async {
    if (fromShared != null) {
      isDark = fromShared;
      emit(HomeChangeThemeState());
    } else {
      isDark = !isDark;
      await Cache.setbool(key: 'isDark', value: isDark);
      emit(HomeChangeThemeState());
    }
  }

  var enumMode = NewsType.allNews;

  String eunmSort = SortByEnum.publishedAt.name;
  void changeEnumMode() {
    emit(HomeChangeEmumMode());
  }

  int currentIndex = 0;

  void changeIndex() {
    getData(page: currentIndex + 1, sortby: eunmSort);
    emit(HomeChangeEmumMode());
  }

  List<String> items = [
    'Football',
    'Flutter',
    'Python',
    'Weather',
    'Crypto',
    'Bitcoin',
    'Youtube',
    'Netflix',
    'Meta'
  ];

  NewsModel? newsModel;
  List<ArticlesModel>? articles;
  void getData({int page = 1, String sortby = 'publishedAt'}) async {
    emit(HomeDataLoading());
    try {
      Response response = await DioHelper.getData(
        endPoint: 'everything',
        query: {
          'q': 'Animals',
          'pageSize': '5',
          'page': page.toString(),
          'sortBy': sortby
        },
      );
      NewsModel.fromjson(response.data);

      articles = response.data!.articles;
      emit(HomeDataSuccessfully());
    } catch (e) {
      print(e.toString());

      if (e is DioError) {
        if (e.response != null && e.response?.statusCode != null) {
          emit(HomeDataFailer(
              'Error ${e.response?.statusCode}: ${e.response?.statusMessage}'));
        } else {
          emit(HomeDataFailer(' Oops! there is an error '));
        }
      } else {
        emit(HomeDataFailer(e.toString()));
      }
    }
  }

  List<ArticlesModel>? topHeadline;
  void getTopHeadline() async {
    emit(HomeDataLoading());
    try {
      Response response = await DioHelper.getData(
        endPoint: 'top-headlines',
        query: {
          'country': 'us',
        },
      );
      NewsModel.fromjson(response.data);

      topHeadline = response.data!.articles;
      emit(HomeDataSuccessfully());
    } catch (e) {
      print(e.toString());

      if (e is DioError) {
        if (e.response != null && e.response?.statusCode != null) {
          emit(HomeDataFailer(
              'Error ${e.response?.statusCode}: ${e.response?.statusMessage}'));
        } else {
          emit(HomeDataFailer(' Oops! there is an error '));
        }
      } else {
        emit(HomeDataFailer(e.toString()));
      }
    }
  }

  List<ArticlesModel>? searchList;
  void getSearchData({required String search}) async {
    emit(HomeDataLoading());
    try {
      Response response = await DioHelper.getData(
        endPoint: 'everything',
        query: {'a': search},
      );
      NewsModel.fromjson(response.data);

      searchList = response.data!.articles;
      emit(HomeDataSuccessfully());
    } catch (e) {
      print(e.toString());

      if (e is DioError) {
        if (e.response != null && e.response?.statusCode != null) {
          emit(HomeDataFailer(
              'Error ${e.response?.statusCode}: ${e.response?.statusMessage}'));
        } else {
          emit(HomeDataFailer(' Oops! there is an error '));
        }
      } else {
        emit(HomeDataFailer(e.toString()));
      }
    }
  }
}
