

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/modules/shop_app/shop_login/cubit/states.dart';
import 'package:udemy_flutter/network/remote/dioHelper.dart';

import '../../../../models/shop_app/shop_app_model.dart';
import '../../../../network/end_point.dart';


class ShopLoginCubit extends Cubit<ShopLoginState>{

  ShopLoginCubit(): super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    @required String? email,
    @required String? password
})
  {
    emit(ShopLoginLoadingState());
    ShopDioHelper.postData(
        url: LOGIN,
        data: {
          'email': email,
          'password': password,
        }).then((value)
    {
      value.data;
      print(value.data);
     var loginModel = ShopUserModel.fromJson(value.data);
     print(loginModel.status);
      print(loginModel.message);
      print(loginModel.data.token);
      emit(ShopLoginSuccessState(loginModel));
      

    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

   IconData suffix = Icons.visibility_outlined;
   bool isPassword = true;
  void changePasswordvisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;

    emit(ShopChangePasswordVisibilityState());
    throw Exception();

  }

}