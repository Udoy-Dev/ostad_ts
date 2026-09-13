import 'package:flutter/material.dart';
import 'package:ostad_ts/MainScreen/MainUi/UpdateProfile.dart';
import 'package:ostad_ts/MainScreen/SetupScreen/EmailVerificationScreen.dart';
import 'package:ostad_ts/MainScreen/SetupScreen/LoginScreen.dart';
import 'package:ostad_ts/MainScreen/SetupScreen/ResetPassword.dart';
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

                ListTile(
                  leading: Icon(Icons.person_outline,color: Colors.green,),
                  title: Text('Profile Update'),
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
                ListTile(
                  leading: Icon(Icons.verified_outlined, color: Colors.orange),
                  title: Text('Email Verification Screen'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EmailVerificationScreen(email: AuthController.userData!.email.toString()),));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.password, color: Colors.blue),
                  title: Text('Reset Password'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: AuthController.userData!.email.toString(), otp: AuthController.userData!.toString()),));
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
              await AuthController.logout();
              if (!context.mounted) return;

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
              );
            },
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}