import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/Model/task.dart';
import 'package:todo_test/firebase_utils.dart';


class ListProvider extends ChangeNotifier {
  late Task task;

  List<Task> taskList = [];

  DateTime selectedDate = DateTime.now();

  void getTaskFromFireStore(String uId) async {
    QuerySnapshot<Task> querySnapshot =
    await FirebaseUtils.getTaskSFromFireStore(uId).get();
    notifyListeners();

    //List<QueryDocumentSnapshot<Task>>  => List<Task>
    taskList = querySnapshot.docs.map((doc) {
      return doc.data();
    }
    ).toList();


    taskList.where((task) {
      if (selectedDate.day == task.dateTime?.day &&
          selectedDate.month == task.dateTime?.month &&
          selectedDate.year == task.dateTime?.year) {
        return true;
      }
      return false;
    }).toList();

    taskList.sort((Task task1, Task task2) {
      return task1.dateTime!.compareTo(task2.dateTime!);
    });
    notifyListeners();
  }

  void changeSelectedDate(DateTime newSelectedDate , String uId) {
    selectedDate = newSelectedDate;
    getTaskFromFireStore(uId);
  }
}