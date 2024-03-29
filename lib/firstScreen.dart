// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, invalid_required_named_param


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/archivedTasksScreen.dart';
import 'package:flutter_app/doneTasksScreen.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'constants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'newTasksScreen.dart';


var scaffoldKey = GlobalKey<ScaffoldState>();
var formKey = GlobalKey<FormState>();
var sKey = scaffoldKey.currentState;
TextEditingController titleController = TextEditingController();
TextEditingController timeController = TextEditingController();
TextEditingController dateController = TextEditingController();


class FirstScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text('${cubit.titles[AppCubit.get(context).currentIndex]}'),
              centerTitle: true,
            ),
            /*
      * ConditionalBuilder(
        condition: tasks.length > 0,
        builder: (context) => screens[currentIndex],
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
      * */
            body: cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.fbPressed) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertIntoDatabase(
                        taskName: titleController.text,
                        date: dateController.text,
                        time: timeController.text
                    );
                  }
                } else {
                  titleController = TextEditingController();
                  timeController = TextEditingController();
                  dateController = TextEditingController();
                  sKey!.showBottomSheet((context) =>
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          color: Colors.blueGrey[900],
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.title,
                                      size: 30.0,
                                    ),
                                    border: OutlineInputBorder(),
                                    hintText: 'A new Task What is it?!',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Title shouldn't be empty.";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                TextFormField(
                                  controller: timeController,
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.watch_later_outlined,
                                      size: 30.0,
                                    ),
                                    border: OutlineInputBorder(),
                                    hintText: 'Pick the time!',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Time shouldn't be empty.";
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      //it will open on the position while i'm waiting
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                      print(value.format(context).toString());
                                    }).catchError((error) {
                                      print(
                                          "This error ${error
                                              .toString()} happened while picking time");
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                TextFormField(
                                  controller: dateController,
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.calendar_today,
                                      size: 30.0,
                                    ),
                                    border: OutlineInputBorder(),
                                    hintText: 'Pick the date!',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Date shouldn't be empty.";
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2022-05-22'),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ).closed.then((value) {
                    cubit.changeBottomSheetState(
                        isShow: false,
                        icon: Icons.edit
                    );
                  });
                  cubit.changeBottomSheetState(
                      isShow: true,
                      icon: Icons.add
                  );
                }
              },
              // ignore: prefer_const_constructors
              child: Icon(
                cubit.mainIcon,
                size: 30.0,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 50.0,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.view_list,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archived',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: 'Done',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}