import 'package:flutter/material.dart';
import 'package:task_managment_app/ui/screens/new_task_screen.dart';
import 'package:task_managment_app/ui/widgets/app_bar_widget.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  static String name = "main-layout-screen";

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int selectedIndex = 0;

  List<Widget> screens = [
    NewTaskScreen(),
    NewTaskScreen(),
    NewTaskScreen(),
    NewTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      body: screens[selectedIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        indicatorColor: ColorScheme.of(context).primary,
        selectedIndex: selectedIndex,
        backgroundColor: Colors.white,
        elevation: 10,
        surfaceTintColor: Colors.white,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.new_label_outlined, color: Colors.black54),
            label: "New task",
          ),
          NavigationDestination(
            icon: Icon(Icons.task_alt_outlined, color: Colors.black54),
            label: "Completed",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.cancel_presentation_outlined,
              color: Colors.black54,
            ),
            label: "Canceled",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.history_toggle_off_outlined,
              color: Colors.black54,
            ),
            label: "Progressing",
          ),
        ],
      ),
    );
  }
}
