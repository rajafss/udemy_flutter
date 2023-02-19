import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/state.dart';
import 'package:udemy_flutter/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:udemy_flutter/modules/shop_app/search/search_screen.dart';
import 'package:udemy_flutter/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:udemy_flutter/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/compenents/compenent.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return
      BlocConsumer<ShopCubit, ShopStates>(
        listener: (context,state){},
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(
              title: Text('Products'),
              actions: [
                IconButton(onPressed: (){
                  navigateTo(context, SearchScreen());
                }, icon: Icon(Icons.search)),
                TextButton(onPressed: (){

                  navigateTo(context, OnBoardingScreen());
                  // CachHelper.removeData(key: 'token').then((value)
                  // {
                  //   if(value) navigateAndFinish(context, ShopLoginScreen());
                  // });
                }, child: Text('LOGOUT')),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],

            bottomNavigationBar: BottomNavigationBar(
                onTap: (index){
                  cubit.changeBottomNav(index);
                },
                currentIndex: cubit.currentIndex,
                items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ]),
          );
        },

      );
  }
}
