import 'package:udemy_flutter/models/shop_app/shop_app_model.dart';

abstract class ShopLoginState{}

class ShopLoginInitialState extends ShopLoginState{}

class ShopLoginLoadingState extends ShopLoginState{}

class ShopLoginSuccessState extends ShopLoginState{
 final ShopUserModel loginModel ;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginState{

  final String error;

  ShopLoginErrorState(this.error);

}


class ShopChangePasswordVisibilityState extends ShopLoginState{}
