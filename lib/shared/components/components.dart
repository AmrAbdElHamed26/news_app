
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/modules/web_view/web_view_screen.dart';

import '../../layouts/newsapp/cubit/cubit.dart';
import '../../layouts/newsapp/cubit/states.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: (){
          function() ;
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function ?onSubmit,
  Function ?onChange,
  Function ?onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData ?suffix ,
  Function ?suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (value){onSubmit!(value);},
      onChanged: (value){onChange!(value);},
      onTap: (){onTap!() ; },
      validator: (value){
        validate(value);

        },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: (){suffixPressed!();},
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );


Widget buildArticleItem(Map<String , dynamic> article , context)=>InkWell(
  onTap: (){
     navigateTo(context, WebViewScreen(url: article['url']));
  },
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        Container(
  
          width: 120,
  
          height: 120,
  
          decoration: BoxDecoration(
  
            borderRadius: BorderRadius.circular(20),
  
            image: DecorationImage(
  
              image: NetworkImage('${article['urlToImage']}'),
  
              fit:BoxFit.cover,
  
            ),
  
          ),
  
        ),
  
        SizedBox(width: 10,),
  
        Expanded(
  
          child: Container(
  
            height: 120,
  
            child: Column(
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              children: [
  
                Expanded(
  
                  child: Text(
  
                    '${article['title']}',
  
                    style: Theme.of(context).textTheme.bodyText1,
  
                    overflow: TextOverflow.ellipsis,
  
                    maxLines: 2,
  
                  ),
  
                ),
  
                Text(
  
                  "${article['publishedAt']}",
  
                  style: TextStyle(
  
                    color: Colors.grey ,
  
                  ),
  
                ),
  
              ],
  
            ),
  
          ),
  
        ),
  
      ],
  
    ),
  
  ),
);

Widget myDivider()=> Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);


Widget articleBulider(list , context ){
  return BlocConsumer<NewsCubit , NewsStates>(
    builder: (context , state){
      return ConditionalBuilder(
        condition: list.length > 0 ,
        builder:(context)=> ListView.separated(
          physics:   BouncingScrollPhysics(),
          itemBuilder: (context , index)=>buildArticleItem(list[index] , context),
          separatorBuilder: (context , index)=> myDivider(),
          itemCount: list.length,
        ),
        fallback: (context)=> Center(child: CircularProgressIndicator()),
      );
    },
    listener: (context , state){},
  );
}



void navigateTo(context , widget ){
  Navigator.push(
    context ,
    MaterialPageRoute(
      builder: (context)=>widget ,
    ),
  );
}
