import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managment_app/ui/screens/forget_password_email.dart';
import 'package:task_managment_app/ui/screens/main_layout_screen.dart';
import 'package:task_managment_app/ui/screens/new_task_screen.dart';
import 'package:task_managment_app/ui/screens/sign_up_screen.dart';
import 'package:task_managment_app/ui/widgets/app_bar_widget.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static String name = "add-new-task-screen";

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreen();
}

class _AddNewTaskScreen extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      body: ScreenBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add New Task",
                  style: TextTheme.of(context).bodyLarge,
                ),
                SizedBox(height: 5),
                TextFormField(
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(hintText: "Subject"),
                ),
                TextFormField(
                  maxLines: 5,
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(hintText: "Description"),
                ),
                SizedBox(height: 5),
                FilledButton(
                  onPressed: _onTapAddNewTask,
                  child: Icon(Icons.arrow_circle_right_outlined, size: 25),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  void _onTapAddNewTask(){
    Navigator.pushReplacementNamed(context, MainLayoutScreen.name);
  }

}
