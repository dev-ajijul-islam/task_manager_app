import 'package:flutter/material.dart';
import 'package:task_managment_app/ui/controllers/auth_controller.dart';
import 'package:task_managment_app/ui/screens/sign_in_screen.dart';
import 'package:task_managment_app/ui/screens/update_profile_screen.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      title: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, UpdateProfileScreen.name);
        },
        child: Row(
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
      ),
      backgroundColor: ColorScheme.of(context).primary,
      actions: [
        IconButton(onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (route) => false,);
          AuthController.clearUserData();
        }, icon: Icon(Icons.logout_outlined)),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
