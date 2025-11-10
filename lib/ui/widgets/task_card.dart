import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        tileColor: Colors.white60,
        title: Text(
          "Title of Task 1",
          style: TextTheme.of(context).titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "It is a long established fact that a reader will be distracted by the readable",
              style: TextTheme.of(context).titleSmall?.copyWith(
                color: ColorScheme.of(context).secondary,
              ),
            ),
            Text(
              "02-02-2026",
              style: TextTheme.of(context).titleSmall?.copyWith(
                color: Colors.black54,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  padding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 30,
                  ),
                  color: WidgetStateColor.resolveWith((states) {
                    return Colors.blue.shade300;
                  }),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  label: Text("New"),
                  labelPadding: EdgeInsets.all(0),
                  labelStyle: TextTheme.of(
                    context,
                  ).bodySmall?.copyWith(color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit_note_outlined),
                      color: Colors.blue.shade400,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete_outline),
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}