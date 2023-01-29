
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layouts/newsapp/cubit/states.dart';
import 'package:newsapp/modules/business/businessscreen.dart';
import 'package:newsapp/modules/sports/sportsscreen.dart';

import '../../../modules/science/sciencescreen.dart';
import '../../../modules/settings/setting_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{

  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context)=> BlocProvider.of(context);


  int currentIndex = 0 ;


  List<BottomNavigationBarItem>bottomItems = const [
    BottomNavigationBarItem(
        icon:Icon(
          Icons.business_sharp,
        ),
      label: 'Bussines',
    ),
    BottomNavigationBarItem(
      icon:Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon:Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
   /* BottomNavigationBarItem(
      icon:Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
*/

  ];

  List<Widget> screens=[

    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    //SettingsScreen(),

  ];
  void changeBottomNavBar(int index ){
    currentIndex = index ;
    if(currentIndex == 1 )getSportsData();
    else if (currentIndex == 2 )getScienceData();
    emit(NewsBottomNavigationStates());
  }


  List<dynamic> business = [];
  void getBusinessData(){

    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'a5840f15dc41486997d2bae2e5df02bf'
        }
    ).then((value){
      print(value.data.toString());

      business = value.data['articles'];


      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error));
    });
  }



  List<dynamic> sports = [];
  void getSportsData(){

    emit(NewsGetSportsLoadingState());

    if (sports.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apiKey':'a5840f15dc41486997d2bae2e5df02bf'
          }
      ).then((value){
        print(value.data.toString());

        sports = value.data['articles'];


        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error));
      });
    }
    else{
      emit(NewsGetSportsSuccessState());
    }
  }



  List<dynamic> science = [];
  void getScienceData(){

    emit(NewsGetScienceLoadingState());


    if (science.length == 0 ){

      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'a5840f15dc41486997d2bae2e5df02bf'
          }
      ).then((value){
        print(value.data.toString());

        science = value.data['articles'];


        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error));
      });
    }
    else {
      emit(NewsGetScienceSuccessState());
    }
  }


  List<dynamic> search = [];
  void getSearchData(String value){

    emit(NewsGetSearchLoadingState());


    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'${value}',
          'apiKey':'a5840f15dc41486997d2bae2e5df02bf'
        }
    ).then((value){
      print(value.data.toString());

      search = value.data['articles'];


      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error));
    });

  }

}