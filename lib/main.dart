import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ostad_ts/MainScreen/SetupScreen/SplashScreen.dart';
import 'package:ostad_ts/widgets/ThemData.dart';

void main(){
  runApp(TaskManager());
}

class TaskManager extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      theme: ThemData(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),

    );

  }

}