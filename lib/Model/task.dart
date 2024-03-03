import 'package:intl/date_time_patterns.dart';

class Task {

  static const String collectionName = 'task' ;

  String? taskId ;
  String? title ;
  DateTime? dateTime ;
  bool? isDone ;

  Task ({this.taskId = '', required this.title , required this.dateTime, this.isDone = false});

  Task.fromFireStore (Map<String , dynamic> data):this(
    taskId: data['taskId'] as String ,
    title: data['title'] as String ,
    dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
    isDone: data['isDone']
  );

  Map<String,dynamic> toFireStore () {
    return {
      "taskId" : taskId ,
      "title" : title ,
      "dateTime" : dateTime?.microsecondsSinceEpoch ,
      "isDone" : isDone
    };
  }
}