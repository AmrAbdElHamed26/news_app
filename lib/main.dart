import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/layouts/newsapp/cubit/cubit.dart';
import 'package:newsapp/layouts/newsapp/cubit/maincubit/appstates.dart';
import 'package:newsapp/shared/network/local/chace_helper.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';
import 'package:newsapp/shared/styles/bloc_observer.dart';

import 'layouts/newsapp/cubit/maincubit/appcubit.dart';
import 'layouts/newsapp/news_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized() ; // عشان اضمن ان كل حاجه تخلص وبعدين البرنامج يرن وده بسبب ان main بقت async

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? dark = CacheHelper.getData(key: 'isDark');

  runApp( MyApp(dark ));

}

class MyApp extends StatelessWidget {

  bool? isDark ;
  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
          BlocProvider(create: (context)=>NewsCubit()..getBusinessData()..getScienceData()..getSportsData(),),
          BlocProvider(create: (BuildContext context )=>AppCubit() .. changeAppMode(fromShared: isDark),)
      ],
      child: BlocConsumer<AppCubit , AppStates>(
          listener: (context , state){},
          builder:  (context , state){
            return MaterialApp(


              theme: ThemeData(
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize:20,
                    fontWeight: FontWeight.bold ,
                    color: Colors.black,
                  ),
                ),

                primarySwatch: Colors.deepOrange,
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange ,
                ),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(

                  titleSpacing: 20,

                    iconTheme: IconThemeData(
                      color: Colors.deepOrange,
                    ),

                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white ,
                      statusBarIconBrightness: Brightness.dark ,
                    ),
                    color: Colors.white ,
                    elevation: 0 ,
                    titleTextStyle: TextStyle(
                      color: Colors.black ,
                      fontWeight: FontWeight.bold ,
                      fontSize: 20 ,
                    )
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                ),
              ),

              darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange ,
                ),
                scaffoldBackgroundColor: HexColor('333739') ,
                appBarTheme: AppBarTheme(

                  titleSpacing: 20,
                    iconTheme: IconThemeData(
                      color: Colors.deepOrange,
                    ),

                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('333739') ,
                      statusBarIconBrightness: Brightness.light ,
                    ),
                    color: HexColor('333739'),
                    elevation: 0 ,
                    titleTextStyle: TextStyle(
                      color: Colors.white ,
                      fontWeight: FontWeight.bold ,
                      fontSize: 20 ,
                    )
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: HexColor('333739'),
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey ,
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize:20,
                    fontWeight: FontWeight.bold ,
                    color: Colors.white,
                  ),
                ),
              ),

              themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,

              debugShowCheckedModeBanner: false,
              home: NewsLayout(),
            );
          },
      ),
    );
  }
}
