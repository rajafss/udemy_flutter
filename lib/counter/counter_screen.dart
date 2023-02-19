import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CounterScreen extends StatelessWidget {
   CounterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterState>(
        listener: (context, state)
        {
          if(state is CounterMinusState)
          {
            print('minus state ${state.counter}');
          }
          if(state is CounterPlusState)
          {
            print('state plus ${state.counter}');
          }

        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (){
                      CounterCubit.get(context).minus();
                    },
                    child: Text('munis',style: TextStyle(fontSize: 20.0),),
                  ),
                  Text(
                      '${CounterCubit.get(context).counter}',style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: (){
                      CounterCubit.get(context).plus();
                    },
                    child: Text('plus',style: TextStyle(fontSize: 20.0)),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
