
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layouts/newsapp/cubit/maincubit/appstates.dart';
import 'package:newsapp/layouts/newsapp/cubit/states.dart';
import 'package:newsapp/shared/network/local/chace_helper.dart';


class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(AppInitialStates());

  static AppCubit get(context)=> BlocProvider.of(context);


  ThemeMode appMode = ThemeMode.dark ;
  bool isDark = false ;
  void changeAppMode ({ bool? fromShared}){

    isDark  ;

    if(fromShared == true || fromShared == false  ){
      isDark = fromShared! ;
      emit(ChangeModeState());
    }
    else{
      isDark = !isDark ;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value){

        emit(ChangeModeState()) ;

      });
    }

  }

}