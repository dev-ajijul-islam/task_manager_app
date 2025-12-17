import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/providers/user_provider.dart';
import 'package:task_managment_app/ui/controllers/auth_controller.dart';
import 'package:task_managment_app/ui/screens/sign_in_screen.dart';
import 'package:task_managment_app/ui/screens/update_profile_screen.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ImageProvider? userImage = _getUserImage();
    String initials = _getInitials();

    return AppBar(
      foregroundColor: Colors.white,
      backgroundColor: ColorScheme.of(context).primary,
      title: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, UpdateProfileScreen.name);
        },
        child: Consumer<UserProvider>(
          builder: (context, UserProvider provider, child) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 10,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: ColorScheme.of(context).secondary,
                    backgroundImage: userImage,
                    child: userImage == null
                        ? Text(
                            initials,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${provider.user?.firstName ?? ""} ${provider.user?.lastName ?? ""}",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                      Text(
                        provider.user?.email ?? "",
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      actions: [
        Consumer<UserProvider>(
          builder: (context, UserProvider provider, child) {
            return IconButton(
              onPressed: () async {
                provider.clearUserData;
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SignInScreen.name,
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout_outlined),
            );
          },
        ),
      ],
    );
  }

  ImageProvider? _getUserImage() {
    final photo = provider.user?.photo;

    if (photo == null || photo.isEmpty) return null;

    try {
      return MemoryImage(base64Decode(photo));
    } catch (_) {
      return null;
    }
  }

  String _getInitials() {
    final f = provider.user?.firstName.isNotEmpty == true
        ? provider.user!.firstName[0]
        : "A";

    final l = provider.user?.lastName.isNotEmpty == true
        ? provider.user!.lastName[0]
        : "I";

    return (f + l).toUpperCase();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
