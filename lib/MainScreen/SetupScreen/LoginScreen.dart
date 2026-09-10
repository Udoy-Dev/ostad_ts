import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ostad_ts/AuthController/AuthController.dart';
import 'package:ostad_ts/MainScreen/MainUi/MainNavScreen.dart';
import 'package:ostad_ts/MainScreen/SetupScreen/SingUpScreen.dart';
import 'package:ostad_ts/Models/ApiResponse.dart';
import 'package:ostad_ts/Models/UserModel.dart';
import 'package:ostad_ts/Service/ApiCaller.dart';
import 'package:ostad_ts/Utils/TSManagerURL.dart';
import 'package:ostad_ts/widgets/ScreenBG.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  onLogin(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SingUpScreen()),
    );
  }

  onTabLoginMain()async{
    final ApiResponse response =await ApiCaller.postRequest(url: TSManagerURL.loginUrl,
    body: {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
    }
    );

    if (response.isSuccess){
      UserModel model = UserModel.fromJson(response.responseData['data']);
      String token = response.responseData['token'];
      AuthController.saveData(model, token);
      bool isLogin = await AuthController.isUserLogin();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => isLogin ? MainNavScreen(): LoginScreen(),));
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreeBG(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 150),
                Text(
                  "Login Screen",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Enter your email'),
                ),
                SizedBox(height: 20),
                TextFormField(
                controller: passwordController,
                obscureText: _obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                autofillHints: [AutofillHints.password],
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.trim().length < 3) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
                SizedBox(height: 20),
                FilledButton(onPressed: () {
                  if(formKey.currentState?.validate()==true){
                    onTabLoginMain();
                  }
                }, child: Text("Login")),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("OR"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Have you an account? ',
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = onLogin,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
