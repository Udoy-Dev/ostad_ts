class TSManagerURL{
  static String baseUrl = "https://task.teamrabbil.com/api/v1";
  static String loginUrl = "$baseUrl/Login";
  static String registerUrl = "$baseUrl/Registration";
  static String taskCountStatusUrl = "$baseUrl/taskStatusCount";
  static String taskListByStatueURL(String status) => "$baseUrl/listTaskByStatus/${status}";
  static String updateTaskStatusURL(String ID, String status) => "$baseUrl/updateTaskStatus/${ID}/${status}";
  static String deleteTaskURL(String ID) => "$baseUrl/deleteTask/${ID}";
  static String addNewTask = "$baseUrl/createTask";
}