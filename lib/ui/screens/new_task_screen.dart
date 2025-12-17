import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/data/models/task_count_model.dart';
import 'package:task_managment_app/data/models/task_model.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/providers/new_task_provider.dart';
import 'package:task_managment_app/ui/screens/add_new_task_screen.dart';
import 'package:task_managment_app/ui/widgets/centered_circular_progrress.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';
import 'package:task_managment_app/ui/widgets/task_card.dart';
import 'package:task_managment_app/utils/url.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  static String name = "neq-task-screen";

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  List<TaskCountModel> taskCountList = [];

  @override
  void initState() {
    Future.microtask(() {
      if (mounted) {
        context.read<NewTaskProvider>().getNewTasks();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddTaskButton,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Icon(Icons.add),
      ),
      body: ScreenBackground(
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              SizedBox(
                height: 70,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 5);
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: taskCountList.length,
                  itemBuilder: (context, index) {
                    TaskCountModel taskCount = taskCountList[index];

                    return buildTaskSummary(context, taskCount);
                  },
                ),
              ),
              Consumer<NewTaskProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return CenteredCircularProgrress();
                  } else if (provider.errorMessage != null) {
                    return Text(provider.errorMessage.toString());
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height - 230,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          provider.getNewTasks();
                        },
                        child: ListView.builder(
                          itemCount: provider.newTasks.length,
                          itemBuilder: (context, index) {
                            TaskModel task = provider.newTasks[index];
                            return TaskCard(
                              task: task,
                              onUpdate: () {
                                provider.getNewTasks();
                                getTaskCounts();
                              },
                              onDelete: () {
                                provider.getNewTasks();
                                getTaskCounts();
                              },
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTaskSummary(BuildContext context, TaskCountModel taskCount) {
    return Container(
      width: MediaQuery.of(context).size.width / 4 - 5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              taskCount.sum.toString(),
              style: TextTheme.of(
                context,
              ).bodyMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            Text(taskCount.id, style: TextTheme.of(context).bodySmall),
          ],
        ),
      ),
    );
  }

  Future<void> getTaskCounts() async {
    NetworkResponse response = await NetworkCaller.getRequest(Url.taskCountUrl);

    if (response.isSuccess) {
      List<TaskCountModel> list = [];
      for (Map<String, dynamic> json in response.body["data"]) {
        list.add(TaskCountModel.fromJson(json));
      }

      setState(() {
        taskCountList = list;
      });
    }
    setState(() {});
  }

  void _onTapAddTaskButton() {
    Navigator.pushNamed(context, AddNewTaskScreen.name);
  }
}
