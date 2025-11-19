import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managment_app/ui/controllers/auth_controller.dart';
import 'package:task_managment_app/ui/screens/main_layout_screen.dart';
import 'package:task_managment_app/ui/screens/sign_in_screen.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';
import 'package:task_managment_app/utils/assets_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String name = "splash-screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToNextScreen();
  }

  Future<void> goToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));

    bool isLoggedIn = await AuthController.isUserLoggedIn();

    if (isLoggedIn) {
      await AuthController.getUserData();
      Navigator.pushReplacementNamed(
        context,
        MainLayoutScreen.name,
      );
    } else {
      Navigator.pushReplacementNamed(
        context,
        SignInScreen.name,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(child: SvgPicture.asset(AssetsPath.logoSvg)),
      ),
    );
  }
}
