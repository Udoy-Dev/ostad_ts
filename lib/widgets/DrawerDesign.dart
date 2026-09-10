import 'package:flutter/material.dart';
import 'package:ostad_ts/MainScreen/MainUi/UpdateProfile.dart';
import '../AuthController/AuthController.dart';


class DrawerDesign extends StatelessWidget {
  const DrawerDesign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLLm188hv4_Tz8nXc_vQ1206SNWEvKKwaFCRODAV4OaeDNIrM2JSgmEx4&s=10'),
              ),
            ),
            accountName: Text(
              "${AuthController.userData?.firstName ?? ''} ${AuthController.userData?.lastName ?? ''}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            accountEmail: Text(
              AuthController.userData?.email ?? 'user@example.com',
              style: TextStyle(fontSize: 13),
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // ListTile(
                //   leading: Icon(Icons.check_circle_outline, color: Colors.green),
                //   title: Text('New Tasks'),
                //   onTap: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (context) => NewTaskScreen(),));
                //   },
                // ),
                // ListTile(
                //   leading: Icon(Icons.access_time_rounded, color: Colors.orange),
                //   title: Text('Progress Tasks'),
                //   onTap: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (context) => ProgressTask(),));
                //   },
                // ),
                // ListTile(
                //   leading: Icon(Icons.task_alt_rounded, color: Colors.cyan),
                //   title: Text('Completed Tasks'),
                //   onTap: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (context) => CompletedTask(),));
                //   },
                // ),
                // ListTile(
                //   leading: Icon(Icons.cancel, color: Colors.red),
                //   title: Text('Cancel Tasks'),
                //   onTap: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (context) => CancelTask(),));
                //   },
                // ),
                // Divider(),
                ListTile(
                  leading: Icon(Icons.person_outline,color: Colors.green,),
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfileScreen(initialFirstName: "${AuthController.userData?.firstName.toString() ?? ''}", initialLastName: "Das", initialEmail: "udoy@gmail.xom", initialPhone: "45524124574"),));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.dashboard_outlined, color: Colors.purple),
                  title: Text('Dashboard'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),

          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              // await AuthController.clearData();
              // if (!context.mounted) return;
              //
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(builder: (context) => const LogInScreen()),
              //       (route) => false,
              // );
            },
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}