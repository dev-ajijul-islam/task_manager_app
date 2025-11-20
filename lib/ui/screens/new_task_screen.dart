import 'package:flutter/material.dart';
import 'package:task_managment_app/data/models/task_model.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
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
  bool isLoadingNewTasks = false;
  List<TaskModel> taskList = [];

  @override
  void initState() {
    getNewTasks();
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
                child: GridView.count(
                  childAspectRatio: 1.4,
                  crossAxisCount: 4,
                  crossAxisSpacing: 5,
                  children: [
                    buildTaskSummary(context),
                    buildTaskSummary(context),
                    buildTaskSummary(context),
                    buildTaskSummary(context),
                  ],
                ),
              ),
              Visibility(
                visible: isLoadingNewTasks == false,
                replacement: CenteredCircularProgrress(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 230,
                  child: RefreshIndicator(
                    onRefresh: ()async{
                      getNewTasks();
                    },
                    child: ListView.builder(
                      itemCount: taskList.length,
                      itemBuilder: (context, index) {
                        TaskModel task = taskList[index];
                        return TaskCard(task: task);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTaskSummary(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "09",
              style: TextTheme.of(
                context,
              ).bodyMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            Text("New task", style: TextTheme.of(context).bodySmall),
          ],
        ),
      ),
    );
  }

  Future<void> getNewTasks() async {
    setState(() {
      isLoadingNewTasks = true;
    });

    NetworkResponse response = await NetworkCaller.getRequest(Url.newTaskUrl);

    if (response.isSuccess) {
      List<TaskModel> list = [];

      for (Map<String, dynamic> task in response.body["data"]) {
        list.add(TaskModel.fromJson(task));
      }

      setState(() {
        taskList = list;
      });
    }

    setState(() {
      isLoadingNewTasks = false;
    });
  }

  void _onTapAddTaskButton() {
    Navigator.pushNamed(context, AddNewTaskScreen.name);
  }
}
