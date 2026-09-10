import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ostad_ts/MainScreen/SetupScreen/LoginScreen.dart';
import 'package:ostad_ts/Models/ApiResponse.dart';
import 'package:ostad_ts/Service/ApiCaller.dart';
import 'package:ostad_ts/Utils/TSManagerURL.dart';
import 'package:ostad_ts/widgets/ScreenBG.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {

  bool obscurePassword = true;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  onTabSingUp() async {
    final ApiResponse response = await ApiCaller.postRequest(url: TSManagerURL.registerUrl,
      body: {
        "firstName": firstNameController.text.trim(),
        "lastName": lastNameController.text.trim(),
        "phone": phoneController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      }
    );
    if (response.isSuccess){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ScreeBG(child: Padding(
        padding: EdgeInsets.all(30),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 150,),
              Text("Sing Up Screen",style: Theme.of(context).textTheme.titleLarge,),
              SizedBox(height: 20,),
              TextFormField(
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                controller: firstNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Enter your first name'
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                controller: lastNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    hintText: 'Enter your last name'
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (value.length != 11) {
                    return 'Please enter a valid 11-digit phone number';
                  } else {
                    return null;
                  }
                },

                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                controller: phoneController,
                keyboardType: TextInputType.number,
                maxLength: 11,
                decoration: InputDecoration(
                    hintText: 'Enter your phone number',
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                controller: emailController,
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
                decoration: InputDecoration(
                  hintText: 'Enter your email'
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: passwordController,
                obscureText: obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                autofillHints: const [AutofillHints.password],
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.trim().length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              FilledButton(onPressed: (){

                if(formKey.currentState?.validate()==true){
                  onTabSingUp();
                }


              }, child: Text("Sing Up",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold))),
              SizedBox(height: 10,),
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
              SizedBox(height: 10,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(text: TextSpan(
                      text: "Don't have you an account? ",
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14,letterSpacing: 1),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                          },
                        ),
                      ],
                    ))
                  ]
                ),
              )



            ],
          ),
        ),
      )),

    );
  }
}