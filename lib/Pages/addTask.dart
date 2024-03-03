import 'package:flutter/material.dart';
import 'package:mytask/Classes/Task.dart';
import 'package:mytask/main.dart';

class AddTaskPage extends StatefulWidget {
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  void writeData() {
    //_myBox.put(1, 'mich');
  }

  void readData() {
    // print(_myBox.get(1));
  }
  //
  //

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
