import 'package:flutter/material.dart';
import 'package:task_managment_app/data/models/task_model.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/ui/widgets/centered_circular_progrress.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';
import 'package:task_managment_app/ui/widgets/task_card.dart';
import 'package:task_managment_app/utils/url.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  bool isLoadingTask = false;
  List<TaskModel> taskList = [];

  @override
  void initState() {
    getCanceledTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: RefreshIndicator(
            onRefresh: () async {
              getCanceledTasks();
            },
            child: Visibility(
              visible: isLoadingTask == false,
              replacement: CenteredCircularProgrress(),
              child: ListView.builder(
                itemCount: taskList.length,
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  TaskModel task = taskList[index];
                  return TaskCard(
                    task: task,
                    onUpdate: () {
                      getCanceledTasks();
                    },
                    onDelete: () {
                      getCanceledTasks();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getCanceledTasks() async {
    isLoadingTask = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
      Url.cancelTaskUrl,
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> json in response.body["data"]) {
        list.add(TaskModel.fromJson(json));
      }
      taskList = list;
    }
    isLoadingTask = false;
    setState(() {});
  }
}
