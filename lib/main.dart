import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/shop_app/shop_app_layout.dart';
import 'package:udemy_flutter/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:udemy_flutter/network/remote/dio_helper.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';
import 'package:udemy_flutter/shared/styles/themes.dart';
import 'layout/news_api/cubit/cubit.dart';
import 'layout/news_api/news_api.dart';
import 'package:udemy_flutter/layout/news_api/cubit/cubit.dart';

import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'modules/shop_app/shop_login/cubit/cubit.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dioHelper.dart';
// Bloc.observer = MyBlocObserver();
void main()
{
  ShopDioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();
  // DioHelper.init();
  // CachHelper.init();
  // bool? isDark = CachHelper.getBoolean(key: 'isDark');

   // bool onboarding = CachHelper.getData(key: 'boarding');
   //
   // print(onboarding);
   // Widget widget;

   // Future<String> token = CachHelper.getData(key: 'token');
   // print(token);
   // if(onboarding != null)
   // {
   //   if(token != null) widget = ShopLayout();
   //   else widget = ShopLoginScreen();
   // }
   // else
   // {
   //   widget = OnBoardingScreen();
   // }
  runApp(MyApp());
  // startwidget: widget,

}

class MyApp extends StatelessWidget{
  // final Widget startwidget;
  // MyApp({required this.startwidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> NewsCubit()..getBusiness()..getSports()..getScience(),),
        BlocProvider(create: (context)=> AppCubit()) ,
        BlocProvider(create: (context)=> ShopLoginCubit()) ,
        BlocProvider(create: (context)=> ShopCubit()..getHomeData()) ,
      ],
      child: BlocConsumer<AppCubit, AppStates>(
       listener: (context, state) {},
        builder: (context, state)
        {
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }

}

