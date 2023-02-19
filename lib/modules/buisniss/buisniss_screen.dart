
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/news_api/cubit/states.dart';

import '../../layout/news_api/cubit/cubit.dart';
import '../../shared/compenents/compenent.dart';

class BuisnessScreen extends StatelessWidget {
  const BuisnessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
    builder: (context, state) {
      var list = NewsCubit.get(context).business;

      return articlBuilder(list, context);
    },
    );

  }
}




