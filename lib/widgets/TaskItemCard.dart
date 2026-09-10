import 'package:flutter/material.dart';
import 'package:ostad_ts/Models/TaskModel.dart';
import 'package:ostad_ts/Utils/TSManagerURL.dart';

import '../Models/ApiResponse.dart';
import '../Service/ApiCaller.dart';

class TaskItemCard extends StatefulWidget {
  final TaskModel taskModel;
  final VoidCallback? refreshParent;
  final String static;

  const TaskItemCard({
    super.key,
    required this.taskModel, required this.refreshParent, required this.static,
  });

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'progress':
      case 'in progress':
        return Colors.orange;
      case 'cancel':
      case 'canceled':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  Future <void> deleteTask()async{
    final ApiResponse response = await ApiCaller.getRequest(url: TSManagerURL.deleteTaskURL(widget.taskModel.sId.toString()),);
    if(response.isSuccess){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Task deleted successfully")));
      widget.refreshParent!();
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.errorMessage.toString() )));
    }
  }

  Future<void>updateTaskStatus(String status)async{
    final ApiResponse response = await ApiCaller.getRequest(url: TSManagerURL.updateTaskStatusURL(widget.taskModel.sId.toString(),status));
    if(response.isSuccess){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Task updated successfully")));
      widget.refreshParent!();
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.errorMessage.toString() )));
    }
  }

  void showChangeStatusDialog() {
    showDialog(context: context, builder: (context) => AlertDialog(

      title: Text("Change Statue"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Card(
            child: ListTile(
              title: Text("New"),
              onTap: () {
                updateTaskStatus('New');
                Navigator.pop(context);
              },
              trailing: widget.taskModel.status=='New' ? Icon(Icons.fiber_new_rounded,color: Colors.green,) : null,
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Progress"),
              onTap: () {
                updateTaskStatus('Progress');
                Navigator.pop(context);
              },
              trailing: widget.taskModel.status=='Progress' ? Icon(Icons.autorenew_rounded,color: Colors.lightGreenAccent,) : null,
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Completed"),
              onTap: () {
                updateTaskStatus('Completed');
                Navigator.pop(context);
              },
              trailing: widget.taskModel.status=='Completed' ? Icon(Icons.check_circle_rounded,color: Colors.yellow,) : null,
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Cancel"),
              onTap: () {
                updateTaskStatus('Cancel');
                Navigator.pop(context);
              },
              trailing: widget.taskModel.status=='Cancel' ? Icon(Icons.cancel,color: Colors.red,) : null,
            ),
          ),


        ],
      ),

    ),);
  }


  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(widget.static);
    return Card(
      color: Colors.grey[100],
      elevation: 1.5,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 6),

            Text(
              widget.taskModel.description.toString(),
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10),

            Row(
              children: [
                Icon(Icons.calendar_month_outlined, size: 14, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  "Date: ${widget.taskModel.createdDate}",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
            SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    widget.taskModel.status.toString(),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        showChangeStatusDialog();
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(Icons.edit_note, color: Colors.teal, size: 22),
                      ),
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: (){
                        deleteTask();
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}