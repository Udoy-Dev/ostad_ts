import 'package:flutter/material.dart';
import 'package:ostad_ts/MainScreen/MainUi/AddTask.dart';
import 'package:ostad_ts/MainScreen/MainUi/CancelTask.dart';
import 'package:ostad_ts/MainScreen/MainUi/CompletedTask.dart';
import 'package:ostad_ts/MainScreen/MainUi/NewTaskScreen.dart';
import 'package:ostad_ts/MainScreen/MainUi/ProgressTask.dart';
import 'package:ostad_ts/MainScreen/SetupScreen/LoginScreen.dart';

import '../../AuthController/AuthController.dart';
import '../../widgets/DrawerDesign.dart';
import '../../widgets/TMAppBar.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int selectedIndex = 0;
  List screen = [
    NewTaskScreen(),
    ProgressTask(),
    CompletedTask(),
    CancelTask(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: TMAppBar(),

      body: screen[selectedIndex],

      drawer:  DrawerDesign(),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          selectedIndex = index;
          setState(() {});
        },
        backgroundColor: Colors.grey[200],
        destinations: [
          NavigationDestination(icon: Icon(Icons.task), label: 'New'),
          NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
          NavigationDestination(icon: Icon(Icons.task_alt), label: 'Completed'),
          NavigationDestination(icon: Icon(Icons.cancel), label: 'Cancel'),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTask()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),


    );
  }
}




