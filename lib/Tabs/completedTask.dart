
import 'package:flutter/material.dart';
import 'package:mytask/main.dart';

class FinishedTasksTab extends StatefulWidget {
  @override
  State<FinishedTasksTab> createState() => _FinishedTasksTabState();
}

class _FinishedTasksTabState extends State<FinishedTasksTab> {
  @override
  Widget build(BuildContext context) {
    // Replace with your actual finished task data
    

    return ListView.builder(
      itemCount: finishedTasks.value.length,
      itemBuilder: (context, index) {
         var now = DateTime.now();
     
        final _task = finishedTasks.value[index];
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
        return Card(
          child: ListTile(
            title: Flexible(child: Text(_task.title)),
            subtitle: Flexible(child: Text('Duration: $difString')),
            trailing: Flexible(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    finishedTasks.value.removeAt(index);
                  });
                },
                child: Text('Delete'),
              ),
            ),
          ),
        );
      },
    );
  }
}