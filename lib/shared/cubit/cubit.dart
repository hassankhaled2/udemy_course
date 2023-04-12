
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled13/shared/cubit/states.dart';
import 'package:untitled13/shared/network/local/cache.helper.dart';
import '../../modules/todo_app/archive/archive.dart';
import '../../modules/todo_app/done/done.dart';
import '../../modules/todo_app/tasks/tasks.dart';



class AppCubit extends Cubit<AppStates> {
  AppCubit() :super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  var now = new DateTime.now();


  int currentindex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchiveTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archive Tasks',
  ];

  void changeIndex(int index) {
    currentindex = index;
    emit(AppChangeBottomBarChange());
  }

  Database?database;
  List<Map>newTasks = [];
  List<Map>DoneTasks = [];
  List<Map>ArchivedTasks = [];

  void createDatabase() {
    openDatabase(
      'Todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          ;
          print('Error when Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFormDatabase(database);
        // then((value)
        // {
        //
        //   tasks=value;
        //   print(tasks);
        //   emit(AppGetDatabaseState());
        // });
        // getDataFormDatabase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,}) async
  {
    await database!.transaction((txn) async
    {
      return txn.rawInsert(
          'INSERT INTO tasks(title,date,time,status)VALUES("$title","$date","$time","new")')
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());
        getDataFormDatabase(database);
      }).catchError((error) {
        print('Error when Inserting New Record ${error.toString()}');
      });
    });
  }

  void getDataFormDatabase(database) {
    newTasks = [];
    DoneTasks = [];
    ArchivedTasks = [];
    emit(AppGetDatabaseLoadingState());
    database?.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          DoneTasks.add(element);
        else
          ArchivedTasks.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateData({ required String status,
    required int id,}) async

  {
    database!.rawUpdate(
      'UPDATE tasks SET status = ?  WHERE id = ?',
      ['$status', id],).then((value) {
      getDataFormDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    required int id,}) async

  {
    database!.rawUpdate(
      'DELETE FROM tasks WHERE id = ?', [id],).then((value) {
      getDataFormDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({ required bool isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  bool isDark = false;

  void changeAppMode({bool? fromshared}) {
    if (fromshared != null) {
      isDark = fromshared;
      emit(AppChangModeState());
    }

    else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangModeState());
      });
    }
  }
}
