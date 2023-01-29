import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layouts/newsapp/cubit/cubit.dart';
import 'package:newsapp/layouts/newsapp/cubit/states.dart';
import 'package:newsapp/shared/components/components.dart';

class SportsScreen  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var list =NewsCubit.get(context).sports;
    return  articleBulider(list , context );

  }
}
