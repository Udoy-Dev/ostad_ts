import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ostad_ts/AuthController/AuthController.dart';
import 'package:ostad_ts/MainScreen/MainUi/MainNavScreen.dart';
import 'package:ostad_ts/Models/ApiResponse.dart';
import 'package:ostad_ts/Models/UserModel.dart';
import 'package:ostad_ts/Service/ApiCaller.dart';
import 'package:ostad_ts/Utils/TSManagerURL.dart';

class UpdateProfileScreen extends StatefulWidget {
  final String initialFirstName;
  final String initialLastName;
  final String initialEmail;
  final String initialPhone;

  const UpdateProfileScreen({
    super.key,
    required this.initialFirstName,
    required this.initialLastName,
    required this.initialEmail,
    required this.initialPhone,
  });

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _emailController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  bool _obscurePassword = true;
  bool _inProgress = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.initialEmail);
    _firstNameController = TextEditingController(text: widget.initialFirstName);
    _lastNameController = TextEditingController(text: widget.initialLastName);
    _phoneController = TextEditingController(text: widget.initialPhone);
    _passwordController = TextEditingController();

    UserModel userModel = AuthController.userData!;
    _emailController.text = userModel.email.toString();
    _firstNameController.text = userModel.firstName.toString();
    _lastNameController.text = userModel.lastName.toString();
    _phoneController.text = userModel.mobile.toString();

  }

  Future<void> _onTapUpdateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _inProgress = true;
    });

    // final response = await ApiCaller.postRequest(...);
    //final ApiResponse response = await ApiCaller.postRequest(url: url)

    Map<String, dynamic> requestBody = {
      "email": _emailController.text,
      "firstName": _firstNameController.text,
      "lastName": _lastNameController.text,
      "phone": _phoneController.text,
    };

    if(_passwordController.text.isNotEmpty){
      requestBody['password'] = _passwordController.text;
    }

    final ApiResponse response = await ApiCaller.postRequest(url: TSManagerURL.updateProfile,
      body: requestBody

    );
    if(response.isSuccess){
      UserModel model = UserModel(
        id: AuthController.userData!.id,
        email: _emailController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        mobile: _phoneController.text,
        //createdDate: AuthController.userData!.createdDate,
      );
      await AuthController.updateUserData(model);
      setState(() {

      });
      //Navigator.push(context, MaterialPageRoute(builder: (context) => MainNavScreen(),));
    }

    await Future.delayed(const Duration(seconds: 2)); 

    setState(() {
      _inProgress = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Update Profile'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. Profile Picture Avatar with Camera Badge
                Center(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF2563EB),
                            width: 2,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundColor: Color(0xFFEFF6FF),
                          child: Icon(
                            Icons.person,
                            size: 55,
                            color: Color(0xFF2563EB),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {

                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xFF2563EB),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),


                SizedBox(height: 16),

                // 3. First Name
                TextFormField(
                  controller: _firstNameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 4. Last Name
                TextFormField(
                  controller: _lastNameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 5. Phone Number
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  maxLength: 11,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone_android_outlined),
                    border: OutlineInputBorder(),
                    counterText: "",
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (value.trim().length != 11) {
                      return 'Please enter a valid 11-digit phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 6. Optional Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    labelText: 'Password (Optional)',
                    hintText: 'Leave empty to keep current password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
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
                    if (value != null &&
                        value.isNotEmpty &&
                        value.trim().length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // 7. Save Changes Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Visibility(
                    visible: !_inProgress,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: _onTapUpdateProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
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