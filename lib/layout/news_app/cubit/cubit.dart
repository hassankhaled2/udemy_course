

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/layout/news_app/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/layout/news_app/cubit/cubit.dart';
import 'package:untitled13/layout/news_app/cubit/states.dart';
import 'package:untitled13/shared/components/components.dart';
import '../../../modules/news_app/Business/business _screeen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/sports/sports_screen.dart';
import '../../../shared/network/remote/dio.helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() :super(NewInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomitem = [
    BottomNavigationBarItem(
      label: "Business",
      icon: Icon(Icons.business),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: "sport",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: "Science",
    ),
  ];
  List<Widget>screens =
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    if (index == 1)
      getSport();
    if (index == 2)
      getScience();
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'ca2b29db6d8e40bf94fc0386580f1f0d',

      },).then((value) {
      // print(value?.data.toString());
      business = value?.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSport() {
    emit(NewsGetSportLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': 'ca2b29db6d8e40bf94fc0386580f1f0d',

        },).then((value) {
        // print(value?.data.toString());
        sports = value?.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportSuccessState());
    }
  }

  List<dynamic> sciences = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (sciences.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': 'ca2b29db6d8e40bf94fc0386580f1f0d',

        },).then((value) {
        // print(value?.data.toString());
        sciences = value?.data['articles'];
        print(sciences[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': 'ca2b29db6d8e40bf94fc0386580f1f0d',

      },).then((value) {
      // print(value?.data.toString());
      search = value?.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
