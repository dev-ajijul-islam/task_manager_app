import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        spacing: 10,
        children: [
          CircleAvatar(
            backgroundColor: Colors.green.shade300,
            child: Text("AI"),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ajijul Islam",
                style: TextTheme.of(
                  context,
                ).bodyMedium?.copyWith(color: Colors.white),
              ),
              Text(
                "devajijulislam@gmail.com",
                style: TextTheme.of(
                  context,
                ).bodySmall?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: ColorScheme.of(context).primary,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}