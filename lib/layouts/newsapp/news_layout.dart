import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layouts/newsapp/cubit/cubit.dart';
import 'package:newsapp/layouts/newsapp/cubit/maincubit/appcubit.dart';
import 'package:newsapp/layouts/newsapp/cubit/states.dart';
import 'package:newsapp/modules/search/search_screen.dart';
import 'package:newsapp/shared/components/components.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(

      listener: (context , state){},
      builder: (context , state){
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                onPressed: (){
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(
                    Icons.search
                ),

              ),
              IconButton(
                onPressed: (){


                  AppCubit.get(context).changeAppMode();
                },
                icon: Icon(
                    Icons.brightness_4 ,
                ),

              ),

            ],
          ),
          body: NewsCubit.get(context).screens[NewsCubit.get(context).currentIndex],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: NewsCubit.get(context).currentIndex,
            onTap: (index){
              NewsCubit.get(context).changeBottomNavBar(index);
            },
            items: NewsCubit.get(context).bottomItems,


          ),
        );
      },
    );
  }
}
