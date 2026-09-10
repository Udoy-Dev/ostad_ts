import 'package:flutter/material.dart';

class TaskCount extends StatelessWidget {
  final String title;
  final int count;
  const TaskCount({
    super.key, required this.title, required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(count.toString(),style: TextStyle(color: Colors.black,fontSize: 16),),
            Text(title,style: TextStyle(color: Colors.black,fontSize: 12,),)
          ],
        ),
      ),
    );
  }
}