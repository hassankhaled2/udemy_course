// import 'package:flutter/cupertino.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/shared/components/components.dart';
import 'package:intl/intl.dart';
import 'package:untitled13/shared/cubit/cubit.dart';
import 'package:untitled13/shared/cubit/states.dart';
class HomeLayout extends StatelessWidget {


  var scaffoldkey=GlobalKey<ScaffoldState>();
  var formkey=GlobalKey<FormState>();
  var titleController=TextEditingController();
  var timeController=TextEditingController();
  var dateController=TextEditingController();


  // @override
  // void initState()
  // {
  // super.initState();
  // createDatabase();
  // }
  @override
  Widget build(BuildContext context) {
  return BlocProvider(
    create: (BuildContext context)=> AppCubit()..createDatabase(),
    child: BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context,AppStates state)
      {
        if(state is AppInsertDatabaseState)
        {
          Navigator.pop(context);
        }
      },

      builder:(BuildContext context,AppStates state)
      {
        AppCubit cubit= AppCubit.get(context);
        return  Scaffold(
          key: scaffoldkey,
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentindex]),
          ),
          body: ConditionalBuilder(
            condition: state is! AppGetDatabaseLoadingState,
            builder: (context)=>cubit.screens[cubit.currentindex],
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: ()
            {
              if(cubit.isBottomSheetShown)
              {
                if(formkey.currentState!.validate())
                {
                  cubit.insertToDatabase(title: titleController.text, time: timeController.text, date: dateController.text);
                  // insertToDatabase(title: titleController.text, time: timeController.text, date:dateController.text).then((value)
                  // {
                  //   getDataFormDatabase(database).
                  //   then((value)
                  //   {
                  //     Navigator.pop(context);
                  //     // setState(() {
                  //     // isBottomSheetShown=false;
                  //     // fabIcon=Icons.edit;
                  //     // tasks=value;
                  //     // // print(tasks[0]);
                  //     // });
                  //
                  //   });
                  // });
                }
              }else
              {
                scaffoldkey.currentState!.showBottomSheet((context) =>Container(
                  color: Colors.grey[100],
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key:formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        defaultFormField(
                          type:TextInputType.text,
                          // onSubmit:,
                          // obscureText: ,
                          //  isPassword:true ,
                          controller:titleController ,
                          validate:(String?value)
                          {

                            if(value!.isEmpty)
                            {
                              return 'title must not be empty';
                            }
                            return null;
                          },
                          label: 'Task Title',
                          prefix:Icons.title ,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        defaultFormField(
                          type:TextInputType.datetime,
                          // onSubmit:,
                          //  obscureText:true ,
                          // isPassword:true ,
                          controller:timeController ,
                          onTap: ()
                          {
                            showTimePicker(context: context, initialTime:TimeOfDay.now(),
                            ).then((value)
                            {
                              timeController.text=value!.format(context).toString();
                              print(value.format(context));
                            });
                          },
                          validate:(String?value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'time must not be empty';
                            }
                            return null;
                          },

                          label: 'Task Time',
                          prefix:Icons.watch_later_outlined,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        defaultFormField(
                          type:TextInputType.datetime,
                          // onSubmit:,
                          //  obscureText:true ,

                          controller:dateController ,

                          onTap: ()
                          {
                            showDatePicker(context: context, initialDate:DateTime.now(), firstDate:DateTime.now(), lastDate:DateTime.now(),
                            ).then((value)
                            {
                              dateController.text=DateFormat.yMMMd().format(cubit.now);
                            });
                          },
                          validate:(String?value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'date must not be empty';
                            }
                            return null;
                          },
                          label: 'Task Date',
                          prefix:Icons.calendar_today,
                        ),
                      ],
                    ),
                  ),
                ),
                  elevation: 20.0,
                ).closed.then((value)
                {
                  // Navigator.pop(context);
                cubit.changeBottomSheetState(isShow: false, icon: Icons.edit,);
                  // setState(() {
                  // fabIcon=Icons.edit;
                  // });
                });
                cubit.changeBottomSheetState(isShow: true, icon: Icons.add,);
                // setState(() {
                // fabIcon=Icons.add;
                // });
              };

            },
            child: Icon(
              cubit.fabIcon,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentindex ,
              onTap: (index) {
                cubit.changeIndex(index);
                // setState(() {
                // currentindex = index;
                // });
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'Archived')
              ]),
        );
      },
    ),
  );
  }

  // Future<String> getname() async {
  //   return "hassan khaled";
}





