
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_flutter/shared/compenents/compenent.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';

import '../modules/archive_tasks/archive_tasks_screen.dart';
import '../modules/done_tasks/done_tasks_screen.dart';
import '../modules/new_tasks/new_tasks_screen.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:intl_utils/intl_utils.dart';
class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}
class _HomeLayoutState extends State<HomeLayout>{

var scoffoldKey = GlobalKey<ScaffoldState>();
var formKey = GlobalKey<FormState>();

bool isShowNavBottomSheet = false;
IconData fabIcon = Icons.edit;

var titleTextControler = TextEditingController();
var timerTextControler = TextEditingController();
var dateTextControler = TextEditingController();

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context,state){},
        builder: (context, state)
        {
           var cubit = AppCubit.get(context);
          return Scaffold(
            key: scoffoldKey,
            appBar: AppBar(
              title: Text(
                  cubit.titles[cubit.currentIndex]
              ),
            ),
            body: cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                ///Handling error
                //handling error
                // try
                // {
                //   var name = await getName();
                //   print(name);
                // } catch(error)
                // {
                //   print('error ${error.toString()}');
                // }
                // getName().then((value)
                //     {
                //       print(value);
                //       print('raja sssssssss');
                //       throw('some error!!!!!!!!!!!!!!');
                //     }).catchError((error){
                //   print('error is ${error}');
                // });
                if(isShowNavBottomSheet){
                  if(formKey.currentState!.validate())
                  {
                    cubit.insertToDataBase(
                      title: titleTextControler.text,
                      time: timerTextControler.text,
                      date: dateTextControler.text,
                    ).then((value)
                    {
                      Navigator.pop(context);
                      isShowNavBottomSheet = false;
                      setState(() {
                        fabIcon = Icons.edit;
                      });
                    });
                  }
                }
                else
                {
                  scoffoldKey.currentState?.showBottomSheet((context) =>
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                            TextFormField(
                            controller: titleTextControler,
                            keyboardType: TextInputType.text,
                            validator:(String? value){
                              if(value!.isEmpty)
                              {
                                print('title must not be empty');
                              }
                              return null;
                            } ,
                            decoration: InputDecoration(
                              labelText: 'Title task',
                              prefixIcon: Icon(Icons.title),
                              border: OutlineInputBorder(),
                            ),
                            ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: timerTextControler,
                                keyboardType: TextInputType.datetime,
                                validator:(String? value){
                                  if(value!.isEmpty)
                                  {
                                    print('time must not be empty');
                                  }
                                  return null;
                                } ,
                                onTap: (){
                                 showTimePicker(
                                     context: context,
                                     initialTime: TimeOfDay.now()
                                 ).then((value) {
                                   timerTextControler.text = value!.format(context);
                                   print(value.format(context));
                                 });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Task Time',
                                  prefixIcon: Icon(Icons.watch_later_outlined),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: dateTextControler,
                                keyboardType: TextInputType.datetime,
                                validator:(String? value){
                                  if(value!.isEmpty)
                                  {
                                    print('date must not be empty');
                                  }
                                  return null;
                                } ,
                                onTap: (){
                                 showDatePicker(
                                     context: context,
                                     initialDate: DateTime.now(),
                                     firstDate: DateTime.now(),
                                     lastDate: DateTime.parse('2022-08-12'),
                                 ).then((value)
                                 {
                                   dateTextControler.text = DateFormat.yMMMd().format(value!);
                                   print(DateFormat.yMMMd().format(value));
                                 });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Task date',
                                  prefixIcon: Icon(Icons.calendar_month_outlined),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 20.0,
                  ).closed.then((value)
                  {
                    isShowNavBottomSheet = false;
                    setState(() {
                      fabIcon = Icons.edit;
                    });
                  });
                  isShowNavBottomSheet = true;
                  setState(() {
                    fabIcon = Icons.add;
                  });
                }
              },
              child: Icon(
                  fabIcon
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex:  cubit.currentIndex,
                onTap: (index)
                {
                  cubit.changeIndex(index);

                  print(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                    ),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.check_circle_outline,
                    ),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive_outlined,
                    ),
                    label: 'Archive',
                  ),
                ]
            ),
          );
        },
      ),
    );
  }


}
