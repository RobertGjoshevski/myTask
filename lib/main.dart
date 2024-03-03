import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mytask/Classes/Task.dart';
import 'package:mytask/Tabs/currentTask.dart';
import 'package:mytask/Tabs/completedTask.dart';
import 'package:mytask/settings.dart';
//import 'package:excel/excel.dart';
import 'package:hive/hive.dart';

void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox('mybox');

  runApp(TaskApp());
}

//List<Task> currentTasks = [];
//List<Task> finishedTasks = [];

final ValueNotifier<List<Task>> currentTasks = ValueNotifier<List<Task>>([]);
final ValueNotifier<List<Task>> finishedTasks = ValueNotifier<List<Task>>([]);

void addTask(Task newTask) {
  currentTasks.value.add(newTask);
  currentTasks
      .notifyListeners(); // Notify listeners that a new task has been added
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

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings page
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SettingsPage()));
            },
          ),
        ],
      ),
      body: TaskTabs(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add task page
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddTaskPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TaskTabs extends StatefulWidget {
  @override
  State<TaskTabs> createState() => _TaskTabsState();
}

class _TaskTabsState extends State<TaskTabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: 'Current Tasks'),
              Tab(text: 'Finished Tasks'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ValueListenableBuilder(
                    valueListenable: currentTasks,
                    builder: (BuildContext context, List<Task> value, _) {
                      return CurrentTasksTab(tasks: value);
                    }),
                ValueListenableBuilder(
                    valueListenable: finishedTasks,
                    builder: (BuildContext context, List<Task> value,
                        Widget? child) {
                      return FinishedTasksTab();
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddTaskPage extends StatefulWidget {
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  void writeData() {
    _myBox.put(1, 'mich');
  }

  void readData() {
    print(_myBox.get(1));
  }

  void deleteData() {}

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    // Add this to change the label text style
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Task newTask = Task(
                title: titleController.text,
                description: descriptionController.text,
                startTime: DateTime.now(),
              );
              setState(() {
                addTask(newTask);
              });
              // Implement your logic here
              Navigator.pop(context); // Go back to homepage
            },
            child: Text('Add Task'),
          ),
        ],
      ),
    );
  }
}
