import 'package:flutter/material.dart';
import 'package:task_managment_app/ui/screens/forget_password_email.dart';
import 'package:task_managment_app/ui/screens/forget_password_otp_verification_screen.dart';
import 'package:task_managment_app/ui/screens/main_layout_screen.dart';
import 'package:task_managment_app/ui/screens/sign_in_screen.dart';
import 'package:task_managment_app/ui/screens/splash_screen.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //--------------Color Scheme--------------------
        colorScheme: ColorScheme.light(primary: Colors.green.shade500),
        //--------------input theme---------------------
        inputDecorationTheme: InputDecorationThemeData(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),

          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          fillColor: Colors.white,
          hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        //-----------------------------------------------------

        //-----------------------filled button theme ----------
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            fixedSize: Size(double.maxFinite, 43),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        //-----------------------text theme--------------------
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),

      //------------------------routes---------------------------
      routes: {
        SplashScreen.name: (_) => SplashScreen(),
        MainLayoutScreen.name: (_) => MainLayoutScreen(),
        ForgetPasswordEmail.name : (_)=> ForgetPasswordEmail(),
        SignInScreen.name : (_)=> SignInScreen(),
        ForgetPasswordOtpVerificationScreen.name : (_)=> ForgetPasswordOtpVerificationScreen()
      },
      initialRoute: SplashScreen.name,
    );
  }
}
