import 'package:flutter/material.dart';
import 'package:ostad_ts/MainScreen/MainUi/MainNavScreen.dart';
import 'package:ostad_ts/Models/ApiResponse.dart';
import 'package:ostad_ts/Service/ApiCaller.dart';
import 'package:ostad_ts/Utils/TSManagerURL.dart';
import 'package:ostad_ts/widgets/ScreenBG.dart';
import 'package:ostad_ts/widgets/TMAppBar.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> addNewTaskApiCall()async{
    final ApiResponse response = await ApiCaller.postRequest(url: TSManagerURL.addNewTask,
      body: {
        "title":titleController.text,
        "description": descriptionController.text,
        "status":"New"
      }
    );

    if(response.isSuccess){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Task added successfully")));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainNavScreen(),));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.errorMessage.toString() )));
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: TMAppBar(),

      body: ScreeBG(child: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100,),
              Text("Add Task",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              TextFormField(
                controller: titleController,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                maxLines: 1,
                minLines: 1,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Enter your title"
                ),
                validator: (value){
                  if(value!=null && value.isEmpty){
                    return "Please enter your title";
                  }
                  return null;
                }

              ),
              SizedBox(height: 20,),
              TextFormField(
                  controller: descriptionController,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  maxLines: 6,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Enter your description"
                  ),
                  validator: (value){
                    if(value!=null && value.isEmpty){
                      return "Please enter your description";
                    }
                    return null;
                  }

              ),
              SizedBox(height: 20,),
              FilledButton(onPressed: (){
                if(formKey.currentState!.validate()){
                  addNewTaskApiCall();
                }
              }, child: Text("Save"))

            ],

          ),
        ),
      ))),

    );
  }
}
