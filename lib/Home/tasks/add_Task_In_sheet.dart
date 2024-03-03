import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/Model/task.dart';
import 'package:todo_test/My_theme.dart';
import 'package:todo_test/Providers/Auth_provider.dart';
import 'package:todo_test/Providers/List_provider.dart';
import 'package:todo_test/firebase_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AddTaskInSheet extends StatefulWidget {

  @override
  State<AddTaskInSheet> createState() => _AddTaskInSheetState();
}

class _AddTaskInSheetState extends State<AddTaskInSheet> {

  var selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = ' ';
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {

    listProvider = Provider.of<ListProvider>(context);

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery
              .of(context)
              .size
              .height * 0.04,
        ),
        height: MediaQuery
            .of(context)
            .size
            .height * 0.4,

        child: Form(
          key: formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(AppLocalizations.of(context)!.add_new_task,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: MyTheme.brownColor,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: MyTheme.brownColor,
                        offset: Offset(0, 0),
                        blurRadius: 7,
                      )
                    ]),),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.01,),
              TextFormField(
                onChanged: (text) {
                  title = text ;
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return AppLocalizations.of(context)!.please_enter_task_title;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.task_list,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: MyTheme.brownColor, width: 2)
                    ),
                    errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(width: 2)
                    ),
                    hintStyle: TextStyle(color: MyTheme.lableColor,)
                ),
              ),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.03,),
              Text(AppLocalizations.of(context)!.select_date, style: Theme
                  .of(context)
                  .textTheme
                  .titleSmall,),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.03,),
              GestureDetector(
                onTap: () {
                  showCalendar();
                },
                child: Text(
                    '${selectedDate.day}/''${selectedDate.month}/${selectedDate
                        .year}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.double,
                        color: MyTheme.brownColor
                    )),),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.02,),
              ElevatedButton(
                onPressed: () {
                  addTask();
                },
                child: Text(AppLocalizations.of(context)!.add),
                style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      Task task = Task(
          title: title,
          dateTime: selectedDate);

      var authProvider = Provider.of<AuthProviders>(context , listen: false);

      FirebaseUtils.addTaskToFireStore(task , authProvider.curentUser!.uId!).then((value){
        Navigator.pop(context);
        print('task Add Successfully');
        listProvider.getTaskFromFireStore(authProvider.curentUser!.uId!);
      });
    }
  }
}
