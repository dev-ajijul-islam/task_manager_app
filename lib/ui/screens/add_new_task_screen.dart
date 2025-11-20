import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/ui/screens/forget_password_email.dart';
import 'package:task_managment_app/ui/screens/main_layout_screen.dart';
import 'package:task_managment_app/ui/screens/new_task_screen.dart';
import 'package:task_managment_app/ui/screens/sign_up_screen.dart';
import 'package:task_managment_app/ui/widgets/app_bar_widget.dart';
import 'package:task_managment_app/ui/widgets/centered_circular_progrress.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';
import 'package:task_managment_app/ui/widgets/snackbar_message.dart';
import 'package:task_managment_app/utils/url.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static String name = "add-new-task-screen";

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreen();
}

class _AddNewTaskScreen extends State<AddNewTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();

  bool isAddTaskInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      body: ScreenBackground(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: _formKey,
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
                      controller: _titleTEController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Enter title";
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(hintText: "Subject"),
                    ),
                    TextFormField(
                      controller: _descriptionTEController,
                      maxLines: 5,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Enter description";
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(hintText: "Description"),
                    ),
                    SizedBox(height: 5),
                    Visibility(
                      visible: isAddTaskInProgress == false,
                      replacement: CenteredCircularProgrress(),
                      child: FilledButton(
                        onPressed: _onTapAddNewTask,
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapAddNewTask() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isAddTaskInProgress = true;
      });
      Map<String, dynamic> requestBody = {
        "title": _titleTEController.text,
        "description": _descriptionTEController.text,
        "status": "New",
      };
      NetworkResponse response = await NetworkCaller.postRequest(
        Url.createTaskUrl,
        body: requestBody,
      );

      if (response.isSuccess) {
        snackbarMessgae(context, "Task added successfully");
        _clearForm();
      } else {
        snackbarMessgae(context, response.errorMessage.toString());
      }
      setState(() {
        isAddTaskInProgress = false;
      });
    }
  }

  _clearForm(){
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {

    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
