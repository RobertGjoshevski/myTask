import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mytask/Classes/Task.dart';
import 'package:mytask/Pages/home.dart';
import 'package:mytask/Tabs/currentTask.dart';
import 'package:mytask/Tabs/completedTask.dart';
import 'package:mytask/settings.dart';
//import 'package:excel/excel.dart';
import 'package:hive/hive.dart';

void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox('TaskBox');

  runApp(TaskApp());
}

final ValueNotifier<List<Task>> currentTasks = ValueNotifier<List<Task>>([]);
final ValueNotifier<List<Task>> finishedTasks = ValueNotifier<List<Task>>([]);

void addTask(Task newTask) {
  currentTasks.value.add(newTask);
  currentTasks.notifyListeners(); // Notify listeners that a new task has been added
}

class TaskApp extends StatefulWidget {
  @override
  State<TaskApp> createState() => _TaskAppState();
}

class _TaskAppState extends State<TaskApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
