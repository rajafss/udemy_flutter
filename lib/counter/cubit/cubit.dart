

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/counter/cubit/states.dart';

 class CounterCubit extends Cubit<CounterState>
{
  CounterCubit ():  super(CounterinitialState());

   static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 1;

  void plus()
  {
    counter++;
    emit(CounterPlusState(counter));
  }

  void minus()
  {
    counter--;
    emit(CounterMinusState(counter));
  }

}