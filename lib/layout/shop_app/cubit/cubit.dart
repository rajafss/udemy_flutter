

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/state.dart';
import 'package:udemy_flutter/modules/shop_app/categories/categories_screen.dart';

import 'package:udemy_flutter/modules/shop_app/favorites/favorites_screen.dart';
import 'package:udemy_flutter/modules/shop_app/productes/productes_screen.dart';
import 'package:udemy_flutter/network/remote/dioHelper.dart';

import '../../../models/shop_app/shop_home_model.dart';
import '../../../modules/shop_app/settings/settings_screen.dart';
import '../../../network/end_point.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit(): super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    ProductScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
  late HomeModel homeModel;
  void getHomeData(){
    emit(ShopLoadingState());
    ShopDioHelper.getData(url: HOME).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel.data.product[0].name);
      print(homeModel.status);
      emit(ShopSeccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorState());
    });
  }

}