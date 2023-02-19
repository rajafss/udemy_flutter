import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutter/layout/shop_app/shop_app_layout.dart';
import 'package:udemy_flutter/modules/shop_app/shop_login/cubit/cubit.dart';
import 'package:udemy_flutter/modules/shop_app/shop_login/cubit/states.dart';
import 'package:udemy_flutter/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/compenents/compenent.dart';

import '../shop_register/shop_register_screen.dart';



class ShopLoginScreen extends StatelessWidget {

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var emailControler = TextEditingController();
    var passwordControler = TextEditingController();

    return BlocConsumer<ShopLoginCubit, ShopLoginState>(
    listener: (context, state){
      if(state is ShopLoginSuccessState)
      {
        if(state.loginModel.status)
        {
          print(state.loginModel.data);
          print(state.loginModel.data.name);

            navigateAndFinish(context, ShopLayout());
          }  else
        {
          print(state.loginModel.message);
          showToast(text: state.loginModel.message, state: ToastState.ERROR);

          // Fluttertoast.showToast(
          //     msg: 'please verify your informations',
          //     toastLength: Toast.LENGTH_LONG,
          //     gravity: ToastGravity.BOTTOM,
          //     timeInSecForIosWeb: 8,
          //     backgroundColor: Colors.red,
          //     textColor: Colors.white,
          //     fontSize: 16.0
          // );

        }
      }
    },
      builder: (context, state) {
        return  Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LOGIN',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.black
                      )),
                      Text('login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.black26
                      )),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailControler,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'please enter your email address';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Email Address",
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordControler,

                        validator: (value){
                          if(value!.isEmpty)
                          {
                            return 'please enter your password';
                          }
                        },

                        obscureText: ShopLoginCubit.get(context).isPassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                          onPressed:()
                          {
                            ShopLoginCubit.get(context).changePasswordvisibility();
                            },
                            icon: Icon(ShopLoginCubit.get(context).suffix),),
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock_outline),
                          border: OutlineInputBorder(),

                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (context) =>  Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.pink.shade700,
                          ),
                          child: MaterialButton(
                              onPressed: ()
                              {
                                if(formkey.currentState!.validate())
                                  {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailControler.text,
                                        password: passwordControler.text);



                                  }
                                },
                              child: Text('LOGIN',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )
                              ),
                                 ),
                          ),
                        fallback: (context) => Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('don\'t have an accout?'),
                          TextButton(onPressed: (){
                            navigateTo(context, ShopRegisterScreen());
                          },
                            child: Text("Register"),),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }

    );
  }
}
