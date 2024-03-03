import 'dart:typed_data';

//import 'package:creator/creator.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:mytask/Classes/Task.dart';

Future<List> readExcel() async {
  int maxCols = 0;
  int maxRows = 0;
  ByteData data = await rootBundle.load('assets/data.xlsx');
  var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var excel = Excel.decodeBytes(bytes);
  Sheet sheetObject = excel.tables.values.first;
  List<CompletedTask> tasks = [];
  for (var table in excel.tables.keys) {
    sheetObject = excel[table];
    //print(table); //sheet Name
    maxCols = excel.tables[table]!.maxColumns;
    maxRows = excel.tables[table]!.maxRows;
    //print(maxCols);
    //print(maxRows);

    for (var row = 1; row < maxRows; row++) {
      final StringBuffer buffer = StringBuffer();
      int taskID = 0;
      String taskName = '';
      String taskDescription = '';

      int durDays = -1;
      int durHours = -1;
      int durMinutes = -1;
      String startTime = '';
      String endTime = '';
      String duration = '';

      for (var col = 0; col < maxCols; col++) {
        //print(row);

        var cell = sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row));
        buffer.write('${cell.value} , ');
        switch (col) {
          case 0:
            taskID = cell.value != null ? int.parse(cell.value.toString()) : -1;
            break;
          case 1:
            taskName = cell.value != null ? cell.value.toString() : 'null';
            break;
          case 2:
            taskDescription = cell.value != null ? cell.value.toString() : 'null';
            break;
          case 3:
            durDays = cell.value != null ? int.parse(cell.value.toString()) : -1;
            break;
          case 4:
            durHours = cell.value != null ? int.parse(cell.value.toString()) : -1;
            break;
          case 5:
            durMinutes = cell.value != null ? int.parse(cell.value.toString()) : -1;
            break;
          case 6:
            startTime = cell.value != null ? cell.value.toString() : 'null';
            break;
          case 7:
            endTime = cell.value != null ? cell.value.toString() : 'null';
            break;
          case 8:
            duration = cell.value != null ? cell.value.toString() : 'null';
            break;
        }
      }
      CompletedTask newTask = CompletedTask();
      newTask.taskID = taskID;
      newTask.taskName = taskName;
      newTask.taskDescription = taskDescription;
      newTask.durDays = durDays;
      newTask.durHours = durHours;
      newTask.durMinutes = durMinutes;
      newTask.startTimeString = startTime;
      newTask.endTimeString = endTime;
      newTask.durationString = duration;
      tasks.add(newTask);
    }
  }
  return tasks;
}

// Emitter excelEmitter = Emitter<List<dynamic>>((ref, emit) async {
//   final excelData = await readExcel();
//   emit(excelData);
// }, keepAlive: true);
