



class Task {
  final String title;
  final String description;
  final DateTime startTime;
   DateTime? endTime;

  Task({required this.title, required this.description, required this.startTime, this.endTime});
}