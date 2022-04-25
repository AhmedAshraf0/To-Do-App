// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_app/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import 'constants.dart';
import 'cubit/states.dart';
import 'cubit/cubit.dart';

class NewTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        //after inserting the getdata is working so state is changed, so tasks is changed so the builder starts to working
        var tasks = AppCubit.get(context).newTasks;
        return ListView.separated(
            itemBuilder: (context, index) =>
                Dismissible(  
                  key: Key(tasks[index]['id'].toString()),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40.0,
                          child: Text(tasks[index]["time"]),
                          backgroundColor: Colors.greenAccent,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tasks[index]["title"],
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                tasks[index]["date"],
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        IconButton(
                          onPressed: (){
                            AppCubit.get(context).updateDatabase(status: 'Done', id: tasks[index]["id"]);
                          },
                          icon: Icon(
                            Icons.check_box,
                            color: Colors.green,
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            AppCubit.get(context).updateDatabase(status: 'Archived', id: tasks[index]["id"]);
                          },
                          icon: Icon(
                            Icons.archive,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onDismissed: (direction){
                    AppCubit.get(context).deleteData(id: tasks[index]['id']);
                  },
                ),
            separatorBuilder: (context, index) => Divider(),
            itemCount: tasks.length
        );
      },
    );
  }

}


