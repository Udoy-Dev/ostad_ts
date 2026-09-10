import 'package:flutter/material.dart';

import '../../Models/ApiResponse.dart';
import '../../Models/TaskModel.dart';
import '../../Service/ApiCaller.dart';
import '../../Utils/TSManagerURL.dart';
import '../../widgets/TaskItemCard.dart';

class ProgressTask extends StatefulWidget {
  const ProgressTask({super.key});

  @override
  State<ProgressTask> createState() => _ProgressTaskState();
}

class _ProgressTaskState extends State<ProgressTask> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllTask('Progress');
  }

  List<TaskModel> taskList = [];

  Future<void> getAllTask(String status) async {
    setState(() {
      isLoading = true;
    });
    final ApiResponse response = await ApiCaller.getRequest(
      url: TSManagerURL.taskListByStatueURL(status),
    );

    List<TaskModel> tList = [];

    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        tList.add(TaskModel.fromJson(jsonData));
      }
    } else {
      print("error");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response.errorMessage.toString())));
    }
    setState(() {
      taskList = tList;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Expanded(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : taskList.isEmpty
            ? Center(
                child: Text(
                  "No Data Found",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  final task = taskList[index];
                  return TaskItemCard(
                    taskModel: task,
                    static: 'Progress',
                    refreshParent: () {},
                  );
                },
              ),
      ),
    );
  }
}
