import 'package:flutter/material.dart';
import 'package:task_managment_app/data/models/task_model.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/ui/widgets/centered_circular_progrress.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';
import 'package:task_managment_app/ui/widgets/task_card.dart';
import 'package:task_managment_app/utils/url.dart';

class ProgressingTaskScreen extends StatefulWidget {
  const ProgressingTaskScreen({super.key});

  @override
  State<ProgressingTaskScreen> createState() => _ProgressingTaskScreenState();
}

class _ProgressingTaskScreenState extends State<ProgressingTaskScreen> {
  bool isLoadingTask = false;
  List<TaskModel> taskList = [];

  @override
  void initState() {
    getProgessTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: RefreshIndicator(
            onRefresh: () async {
              getProgessTask();
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
                      getProgessTask();
                    },
                    onDelete: () {
                      getProgessTask();
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

  Future<void> getProgessTask() async {
    isLoadingTask = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
      Url.progressTaskUrl,
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
