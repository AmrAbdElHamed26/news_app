import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layouts/newsapp/cubit/cubit.dart';
import 'package:newsapp/layouts/newsapp/cubit/states.dart';
import 'package:newsapp/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
        builder: (context , state){

          var list = NewsCubit.get(context).search;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Search ',
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.find_in_page),
                ),
              ],
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold ,
                fontSize: 20 ,
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,

                    onChange: (value){

                      NewsCubit.get(context).getSearchData(value);
                    },
                    label: 'Search',
                    prefix: Icons.search,
                    validate: (String value ){
                      if(value.length <= 0 ){
                        return 'Search Must Not Be Empty';
                      }
                      return null;
                    } ,
                  ),
                ),
                Expanded(child: articleBulider(list, context)),
              ],
            ),
          );
        },
        listener: (context , state){},
    );
  }
}


/*
*
* Scaffold(
      appBar: AppBar(),
       body: Column(
         children: [
           Padding(
             padding: const EdgeInsets.all(12.0),
             child: defaultFormField(
                 controller: searchController,
                 type: TextInputType.text,
                 validate: (String value){
                   if(value.length <1 ){
                     return ' Search Must Not Be Empty';
                   }
                   return null ;
                 },
                  onChange: (value){

                  },
                 label: 'Search',
                 prefix: Icons.search ,
             ),
           ),
           Expanded(child: articleBulider(list, context)),
         ],
       ),
    );*/
