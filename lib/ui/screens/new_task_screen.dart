import 'package:flutter/material.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';
import 'package:task_managment_app/ui/widgets/task_card.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
