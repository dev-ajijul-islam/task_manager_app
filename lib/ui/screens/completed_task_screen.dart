import 'package:flutter/material.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';
import 'package:task_managment_app/ui/widgets/task_card.dart';

class CompletedTaskScreen extends StatelessWidget {
  const CompletedTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              TaskCard(),
              TaskCard(),
              TaskCard(),
              TaskCard(),
              TaskCard(),
              TaskCard(),
              TaskCard(),
              TaskCard(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTaskSummary(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.5,
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
}
