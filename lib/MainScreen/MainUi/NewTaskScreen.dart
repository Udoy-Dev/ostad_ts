import 'package:flutter/material.dart';
import 'package:ostad_ts/Models/ApiResponse.dart';
import 'package:ostad_ts/Models/TaskModel.dart';
import 'package:ostad_ts/Models/TaskStatusCountModel.dart';
import 'package:ostad_ts/Service/ApiCaller.dart';
import 'package:ostad_ts/Utils/TSManagerURL.dart';
import 'package:ostad_ts/widgets/TaskItemCard.dart';

import '../../widgets/TaskCount.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllStatus();
    getAllTask('New');
  }

  List<TaskStatusModel> taskCountByStatus = [];
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

  Future<void> getAllStatus() async {

    final ApiResponse response = await ApiCaller.getRequest(
      url: TSManagerURL.taskCountStatusUrl,
    );

    List<TaskStatusModel> taskCount = [];

    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        taskCount.add(TaskStatusModel.fromJson(jsonData));
      }
    } else {
      print("error");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response.errorMessage.toString())));
    }

    setState(() {
      taskCountByStatus = taskCount;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 5,),
          SizedBox(
            height: 60,
            child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: taskCountByStatus.length,
                    itemBuilder: (context, index) {
                      final taskCount = taskCountByStatus[index];
                      return SizedBox(
                        width: 100,
                        child: TaskCount(
                          title: taskCount.sId.toString(),
                          count: taskCount.sum!.toInt(),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 10);
                    },
                  ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : taskList.isEmpty
                ? Center(child: Text("No Data Found"))
                : ListView.builder(
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      final task = taskList[index];
                      return TaskItemCard(
                        taskModel: task,
                        static: 'New',
                        refreshParent: () {
                          getAllTask('New');
                          getAllStatus();
                          setState(() {});
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
