import 'package:analog_clock/analog_clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/Home/task_list_item.dart';
import 'package:todo_test/Home/tasks/add_Task_In_sheet.dart';
import 'package:todo_test/Model/task.dart';
import 'package:todo_test/My_theme.dart';
import 'package:todo_test/Providers/App_config_provider.dart';
import 'package:todo_test/Providers/Auth_provider.dart';
import 'package:todo_test/Providers/List_provider.dart';
import 'package:todo_test/settings/Drower_disign.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {

  static const String routeName = 'home_Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> tasksStream = FirebaseFirestore.instance
        .collection(Task.collectionName).snapshots();

    var provider = Provider.of<AppConfigProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthProviders>(context);


    // if (listProvider.taskList.isEmpty) {
    //   listProvider.getTaskFromFireStore(authProvider.curentUser!.uId!);
    // }
    listProvider.getTaskFromFireStore(authProvider.curentUser!.uId!);

    return Scaffold(
        drawer: Drawer(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.4,
          child: DrowerTab(),
        ),
        appBar: AppBar(
          backgroundColor: MyTheme.backgroundOwner,
          centerTitle: true,
          title: AnalogClock(
            decoration: const BoxDecoration(
              // border: Border.all(width: 2.0, color: MyTheme.brownColor),
                color: Colors.white,
                shape: BoxShape.circle),
            width: MediaQuery
                .of(context)
                .size
                .width * 0.4,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.2,
            isLive: true,
            hourHandColor: MyTheme.blackColor,
            minuteHandColor: MyTheme.blackColor,
            showSecondHand: true,
            numberColor: MyTheme.blackColor,
            showNumbers: true,
            showAllNumbers: false,
            textScaleFactor: 1.4,
            showTicks: true,
            tickColor: MyTheme.blackColor,
            showDigitalClock: true,
            datetime: DateTime.now(),
          ),
          toolbarHeight: MediaQuery
              .of(context)
              .size
              .width * 0.4,),
        body: Column(
          children: [
            EasyDateTimeLine(
              onDateChange: (date) {
                listProvider.changeSelectedDate(date, authProvider.curentUser!.uId!) ;
              },
              initialDate: listProvider.selectedDate,
              activeColor: const Color(0xffFFBF9B),
              headerProps: const EasyHeaderProps(
                dateFormatter: DateFormatter.monthOnly(),
              ),
              dayProps: const EasyDayProps(
                height: 56.0,
                width: 56.0,
                dayStructure: DayStructure.dayNumDayStr,
                inactiveDayStyle: DayStyle(
                  borderRadius: 48.0,
                  dayNumStyle: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                activeDayStyle: DayStyle(
                  dayNumStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // locale: provider.appLanguge,
            ),

            Expanded(

                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02,
                    horizontal: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02,),
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery
                        .of(context)
                        .size
                        .height * 0.01,
                    horizontal: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [BoxShadow(
                      color: MyTheme.backgroundOwner,
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 3),)
                    ],

                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.daily_tasks,
                              style: const TextStyle(fontWeight: FontWeight
                                  .bold, fontSize: 18)),
                          FloatingActionButton.small(
                            backgroundColor: MyTheme.backgroundOwner,
                            onPressed: () {
                              showBottomSheet();
                              setState(() {});
                            },
                            child:
                            Icon(Icons.add, size: 25,
                              color: MyTheme.witheColor,),
                          ),
                        ],
                      ),
                      Expanded(
                        child:
                        ListView.builder(
                          itemBuilder: (context, index) {
                            return TaskListItem(task: listProvider.taskList[index],);
                          },
                          itemCount: listProvider.taskList.length,),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        )
    );
  }

  void showBottomSheet () {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        )),
      showDragHandle: true,
      backgroundColor: MyTheme.witheColor,
        context: context, builder: (context) => AddTaskInSheet());
  }

}


// StreamBuilder(
// stream: tasksStream,
// builder: (context, AsyncSnapshot<
//     QuerySnapshot> snapshot) {
// if (snapshot.hasError) {
// return const Text('Error');
// }
// if (snapshot.connectionState ==
// ConnectionState.waiting) {
// return const Text('Loading');
// }
// return ListView.builder(
// itemBuilder: (context, index) {
// return TaskListItem(
// task: taskList[index],);
// },
// itemCount: taskList.length,);
// }
//
// )