

import 'package:flutter/material.dart';
import 'package:mytask/Classes/Task.dart';
import 'package:mytask/main.dart';

class CurrentTasksTab extends StatefulWidget {
  final List<Task> tasks;

  CurrentTasksTab({required this.tasks});

  
  @override
  State<CurrentTasksTab> createState() => _CurrentTasksTabState();
}

class _CurrentTasksTabState extends State<CurrentTasksTab> {
    void addTask(Task newTask) {
      setState(() {
        currentTasks.value.add(newTask);
      });
    }
  
  @override
  Widget build(BuildContext context) {
    // Replace with your actual task data (e.g., from a database)
    
    return SliverList.builder(
      itemBuilder: (context, index) {
        final _task = currentTasks.value[index];
      var now = DateTime.now();
      var difference = now.difference(_task.startTime);
      var difString = difference.toString();
      //check the diffference and make a string properly ,if the difference is more than 24 hours then show the days, if the difference is more than 60 minutes then show the hours, if the difference is more than 60 seconds then show the minutes, if the difference is more than 60 seconds then show the seconds
      if(difference.inDays > 0){
        difString = difference.inDays.toString() + " days";
      }else if(difference.inHours > 0){
        difString = difference.inHours.toString() + " hours";
      }else if(difference.inMinutes > 0){
        difString = difference.inMinutes.toString() + " minutes";
      }else if(difference.inSeconds > 0){
        difString = difference.inSeconds.toString() + " seconds";
      }
      else difString = "0 seconds";
        return Card(
        child: ListTile(
          dense: true,
          isThreeLine: true,
          
          title: Row(
            children: [
              Text(_task.title),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Icon(Icons.arrow_forward_outlined),
              ),
              Text(difString),
            ],
            
          ),
          subtitle: Text(_task.description),
          
          trailing: ElevatedButton(
            onPressed: () {
              // Move task to finished tasks list
              setState(() {
                _task.endTime = DateTime.now();
              finishedTasks.value.add(_task);
              currentTasks.value.removeAt(index);
              });
              
              
            },
            child: Text('Finish'),
          ),
        ),
      
      
      
       );
    // return ListView.builder(
    // itemCount: currentTasks.value.length,
    // itemBuilder: (context, index) {
    //   final _task = currentTasks.value[index];
    //   var now = DateTime.now();
    //   var difference = now.difference(_task.startTime);
    //   var difString = difference.toString();
    //   //check the diffference and make a string properly ,if the difference is more than 24 hours then show the days, if the difference is more than 60 minutes then show the hours, if the difference is more than 60 seconds then show the minutes, if the difference is more than 60 seconds then show the seconds
    //   if(difference.inDays > 0){
    //     difString = difference.inDays.toString() + " days";
    //   }else if(difference.inHours > 0){
    //     difString = difference.inHours.toString() + " hours";
    //   }else if(difference.inMinutes > 0){
    //     difString = difference.inMinutes.toString() + " minutes";
    //   }else if(difference.inSeconds > 0){
    //     difString = difference.inSeconds.toString() + " seconds";
    //   }
    //   else difString = "0 seconds";
          
    //   return Card(
    //     child: ListTile(
    //       dense: true,
    //       isThreeLine: true,
          
    //       title: Row(
    //         children: [
    //           Text(_task.title),
    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //             child: Icon(Icons.arrow_forward_outlined),
    //           ),
    //           Text(difString),
    //         ],
            
    //       ),
    //       subtitle: Text(_task.description),
          
    //       trailing: ElevatedButton(
    //         onPressed: () {
    //           // Move task to finished tasks list
    //           setState(() {
    //             _task.endTime = DateTime.now();
    //           finishedTasks.value.add(_task);
    //           currentTasks.value.removeAt(index);
    //           });
              
              
    //         },
    //         child: Text('Finish'),
    //       ),
    //     ),
    //   );
    // },
    //       );
  });
}}