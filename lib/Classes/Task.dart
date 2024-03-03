class Task {
  final String title;
  final String description;
  final DateTime startTime;
  DateTime? endTime;

  Task({required this.title, required this.description, required this.startTime, this.endTime});
}

class CompletedTask {
  String title = '';
  String description = '';
  DateTime? startTime;
  DateTime? endTime;
  int taskID = 0;
  String taskName = '';
  String taskDescription = '';
  int durDays = -1;
  int durHours = -1;
  int durMinutes = -1;
  String startTimeString = '';
  String endTimeString = '';
  String durationString = '';
}
