import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_test/Model/task.dart';
import 'package:todo_test/Model/user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FirebaseUtils {

  static CollectionReference<Task> getTaskSFromFireStore(String uId) {
    return getUsersCollection().doc(uId).collection(Task.collectionName)
        .withConverter<Task>(
        fromFirestore: ((snapshot, options) =>
            Task.fromFireStore(snapshot.data()!)),
        toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTaskToFireStore(Task task , String uId) async {
    var taskCollectionFunc = getTaskSFromFireStore(uId);
    DocumentReference<Task> taskDocRef = taskCollectionFunc.doc();
    task.taskId = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task , String uId) {
    return getTaskSFromFireStore(uId).doc(task.taskId).delete();
  }

  static void updateTasksInFireStore(Task task ,String uId , context) {
    var updateTask = getTaskSFromFireStore(uId);
    updateTask.doc(task.taskId).update({
      'title': task.title = 'Finished .. !',
      'change': task.isDone = true,
    });
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance.collection(MyUser.collectionName).
    withConverter(
      fromFirestore: ((snapshot, options) =>
          MyUser.fromFireStore(snapshot.data()!)),
      toFirestore: (myUser, options) => myUser.toFireStore(),);
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.uId).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    var querySnapshot = await getUsersCollection().doc(uId).get();
    return querySnapshot.data();
  }

}