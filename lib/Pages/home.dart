import 'package:flutter/material.dart';
import 'package:mytask/Classes/Task.dart';
import 'package:mytask/Pages/addTask.dart';
import 'package:mytask/Tabs/completedTask.dart';
import 'package:mytask/Tabs/currentTask.dart';
import 'package:mytask/main.dart';
import 'package:mytask/settings.dart';

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
              Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsPage()));
            },
          ),
        ],
      ),
      body: TaskTabs(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add task page
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddTaskPage()));
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
                    builder: (BuildContext context, List<Task> value, Widget? child) {
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
