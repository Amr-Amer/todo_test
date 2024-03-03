import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/Model/task.dart';
import 'package:todo_test/My_theme.dart';
import 'package:todo_test/Providers/Auth_provider.dart';
import 'package:todo_test/Providers/List_provider.dart';
import 'package:todo_test/firebase_utils.dart';

class TaskListItem extends StatefulWidget {

  @override
  State<TaskListItem> createState() => TaskListItemState();

  Task task ;
  TaskListItem ({required this.task}) ;

}

class TaskListItemState extends State<TaskListItem> {
  bool isDone = false ;

  @override
  Widget build(BuildContext context) {

    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthProviders>(context);

    return Container(
      height: MediaQuery.sizeOf(context).height *.05,
      child: Slidable(
       endActionPane: ActionPane(
          extentRatio: 0.2,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
               backgroundColor: MyTheme.brownColor,
                autoClose: true,
                icon: Icons.delete,
                  foregroundColor: Colors.white,
                  // label: '',
                  onPressed: (context){
                 FirebaseUtils.deleteTaskFromFireStore(widget.task , authProvider.curentUser!.uId!).
                 then((value) {
                   print('task deleted');
                   listProvider.getTaskFromFireStore(authProvider.curentUser!.uId!);
                   setState(() {});
                 } );
               }),
            ]),
        startActionPane: ActionPane(
            extentRatio: 0.2,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                  backgroundColor: MyTheme.brownColor,
                  autoClose: true,
                  icon: Icons.edit,
                  foregroundColor: MyTheme.backgroundLight,
                  // label: 'Edit',
                  onPressed: (context){
                    FirebaseUtils.deleteTaskFromFireStore(widget.task , authProvider.curentUser!.uId!).
                    then((value) {
                      print('task Edit');
                      listProvider.getTaskFromFireStore(authProvider.curentUser!.uId!);
                      setState(() {});
                    } );
                  }),
            ]),
        child: Row(
          children: [
            Checkbox(
                value: isDone,
                fillColor: MaterialStatePropertyAll(MyTheme.backgroundOwner),
                // activeColor: Colors.green,
                onChanged:(bool? newValue){
                  setState(() {
                    if (widget.task.isDone == false) {
                      FirebaseUtils.updateTasksInFireStore(
                          widget.task , authProvider.curentUser!.uId! , context);
                      listProvider.getTaskFromFireStore(authProvider.curentUser!.uId!);
                      isDone = newValue!  ;
                      setState(() {

                      });
                    }
                  });
                }),
            Expanded(child: Text(widget.task.title ?? '')),

          ],
        ),
      ),
    );
  }
}

