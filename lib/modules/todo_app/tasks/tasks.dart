import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled13/shared/cubit/cubit.dart';
import 'package:untitled13/shared/cubit/states.dart';

import '../../../shared/components/components.dart';



class NewTasksScreen extends StatelessWidget {


  // const NewTasksScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener:(context,state)
      {

      },
      builder: (context,stat)
      {
        var tasks=AppCubit.get(context).newTasks;
        return taskBuilder(tasks: tasks);
      },
    );

  }
}
