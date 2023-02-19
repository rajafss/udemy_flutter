


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/modules/search/search_screen.dart';
import 'package:udemy_flutter/network/remote/dio_helper.dart';
import 'package:udemy_flutter/shared/compenents/compenent.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class NewsApi extends StatelessWidget {
  const NewsApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News Apps'),
            actions: [
              IconButton(onPressed: (){
                AppCubit.get(context).changeModeApp();
              },
                  icon: Icon(Icons.brightness_4_outlined)),
              IconButton(onPressed: (){
                navigateTo(context, SearchScreen());
              },
                  icon: Icon(Icons.search)),
            ],
          ),


          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
        );

      },
    );
  }
}
