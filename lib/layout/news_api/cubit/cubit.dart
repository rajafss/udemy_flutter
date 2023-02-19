import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/news_api/cubit/states.dart';

import '../../../modules/buisniss/buisniss_screen.dart';
import '../../../modules/sciences/sciences_screen.dart';
import '../../../modules/settings_screens/settings_screen.dart';
import '../../../modules/sports/sports_screen.dart';
import '../../../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialStates());
  static NewsCubit get(context) => BlocProvider.of(context);
  
  int currentIndex =0;
  
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business),
      label: 'Business',

    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Sciences',

    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'sports',

    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'settings',

    ),
    
  ];

  List<Widget> screens= [
    BuisnessScreen(),
    ScienceScreen(),
    SportsScreen(),
    SettingsScreen(),

  ];
   void changeBottomNavBar(int index){
     currentIndex = index;
     if(index == 1)
       getSports();
     if(index == 2)
       getScience();
     emit(NewsBottomNav());
   }

   List<dynamic> business = [];

   void getBusiness(){
     emit(NewsGetBusinessLoadingState());
     DioHelper.getData(
       url: 'v2/top-headlines',
       query: {
         'country':'us',
         'category':'business',
         'apiKey':'c97a90d2ea0343a69d89f321b38e253e',
       }).then((value) {
     // print(value.data.toString());
     business = value.data['articles'];
     print(business[0]['title']);

     emit(NewsGetBusinessSuccessState());
   }).catchError((error){
     print(error.toString());
     emit(NewsGetBusinessErrorState(error.toString()));

     });

   }


//   sports function


  List<dynamic> sports = [];

  void getSports(){
    emit(NewsGetSportsLoadingState());
    if(sports.length == 0)
      {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country':'us',
              'category':'sports',
              'apiKey':'c97a90d2ea0343a69d89f321b38e253e',
            }).then((value) {
          // print(value.data.toString());
          sports = value.data['articles'];
          print(sports[0]['title']);

          emit(NewsGetSportsSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(NewsGetSportsErrorState(error.toString()));

        });

      }   else{
      emit(NewsGetSportsSuccessState());


    }





  }


//  science Function

  List<dynamic> science = [];

  void getScience(){
    emit(NewsGetScienceLoadingState());
    if(science.length == 0){

      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'us',
            'category':'science',
            'apiKey':'c97a90d2ea0343a69d89f321b38e253e',
          }).then((value) {
        // print(value.data.toString());
        science = value.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));

      });

    }else {
      emit(NewsGetScienceSuccessState());

    }

  }

/// search cubit

  List<dynamic> search = [];

  void getSearch(String value){

    emit(NewsGetSearchLoadingState());

    search = [];

    if(search.length == 0){

      DioHelper.getData(
          url: 'v2/everything',
          query: {
            'q':'$value',
            'apiKey':'c97a90d2ea0343a69d89f321b38e253e',
          }).then((value) {
        // print(value.data.toString());
        search = value.data['articles'];
        // print(search[0]['title']);

        emit(NewsGetSearchSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));

      });

    }else {
      emit(NewsGetSearchSuccessState());

    }

  }

}




