import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_flutter/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';

import '../../modules/archive_tasks/archive_tasks_screen.dart';
import '../../modules/done_tasks/done_tasks_screen.dart';
import '../../modules/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit(): super(AppInitialState());

 static AppCubit get(context) => BlocProvider.of(context);

List<Map> tasks = [];
  int currentIndex = 0;

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchiveTasksScreen(),
  ];


  List<String> titles = [

    'Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];


  void changeIndex(int index)
  {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  var database;
  Future<String> getName() async{
    return 'raja saad';
  }

  void createDataBase()
  {
    openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database, version)
        {
          print('database created');
          database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT,  time TEXT, status TEXT )').then((value) {
            print('table created');
          }).catchError((error)
          {
            print('is error ${error.toString()}');
          });
        },
        onOpen: (database)
        {
          getDataFromDatabase(database).then((value)
          {
            tasks = value;
            emit(AppGetDatabaseState());
          });
          print('database opened');
        }

    ).then((value)
    {
      database = value;
      emit(AppCreateDatabaseState());

    });

  }

  Future insertToDataBase({
  required String title,
    required String time,
    required String date,
  })async
  {
   return await database.transaction((txn)
    {
      txn.rawInsert('INSERT INTO tasks(title, date, time, status) VALUES("$title", "$time", "$date", "new")'
      ).then((value)
      {
        print('$value inserted successfuly');
        emit(AppInsertDatabaseState());
      }).catchError((error)
      {
        print('error when insert table ${error.toString()}');
      });

      return null;
    });
  }

Future<List<Map>> getDataFromDatabase(database) async
 {
    return await database.rawQuery('SELECT * FROM tasks');

 }

  bool isDark = false;

  void changeModeApp (){
      isDark = !isDark;
      emit(AppChangeModeState());
  }

}



