import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/data/models/task_count_model.dart';
import 'package:task_managment_app/data/models/task_model.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/providers/new_task_provider.dart';
import 'package:task_managment_app/providers/task_count_provider.dart';
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
  @override
  void initState() {
    Future.microtask(() {
      if (mounted) {
        context.read<NewTaskProvider>().getNewTasks();
        context.read<TaskCountProvider>().getTaskCounts();
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
              Consumer<TaskCountProvider>(
                builder: (context, provider, child) {
                  return SizedBox(
                    height: 70,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 5);
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.taskCounts.length,
                      itemBuilder: (context, index) {
                        TaskCountModel taskCount = provider.taskCounts[index];

                        return buildTaskSummary(context, taskCount, provider);
                      },
                    ),
                  );
                },
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
                          context.read<TaskCountProvider>().getTaskCounts();
                        },
                        child: ListView.builder(
                          itemCount: provider.newTasks.length,
                          itemBuilder: (context, index) {
                            TaskModel task = provider.newTasks[index];
                            return TaskCard(
                              task: task,
                              onUpdate: () {
                                provider.getNewTasks();
                                context.read<TaskCountProvider>();
                              },
                              onDelete: () {
                                provider.getNewTasks();
                                context.read<TaskCountProvider>();
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

  Container buildTaskSummary(
    BuildContext context,
    TaskCountModel taskCount,
    TaskCountProvider provider,
  ) {
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
              provider.isLoading ? "--" : taskCount.sum.toString(),
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

  void _onTapAddTaskButton() {
    Navigator.pushNamed(context, AddNewTaskScreen.name);
  }
}
