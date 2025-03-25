import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:maktrack/domain/entities/asset_path.dart';
import 'package:maktrack/domain/entities/color.dart';
import 'package:maktrack/firebase_auth_implement/firebase_auth_services.dart';
import 'package:maktrack/presentation/pages/auth/sing_in_screen.dart';
import 'package:maktrack/presentation/pages/screen/login&signup_button_screen/smart_task_management.dart';
import 'package:maktrack/presentation/widgets/coustom_drop_Down_manu.dart';
import 'package:maktrack/presentation/widgets/custom_app_bar.dart';
import 'package:maktrack/presentation/widgets/save_password_forget_button.dart';
import 'package:maktrack/presentation/widgets/sing_up_title.dart';


class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  final _userNameTEController = TextEditingController();
  final _emailTEController = TextEditingController();
  final _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool isnotVisible = true;

  String selectedRole = 'Department Name'; // Default role selection

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: RColors.bgColorColorS,
        statusBarIconBrightness: Brightness.dark));
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: _globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  CustomAppBar(
                    text: 'Back',
                    images: AssetPath.logoPng,
                    onPressed: () {
                      Get.offAll(() => SmartTaskManagement());
                    },
                  ),
                  SizedBox(height: 40),
                  SingUpAndTitle(
                    title: 'Request',
                    title2: 'Log in your account & Manage \nYour task',
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _userNameTEController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person_outline_outlined,
                        size: 20,
                        color: RColors.smallFontColor,
                      ),
                      hintText: "UserName",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your username";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        size: 20,
                        color: RColors.smallFontColor,
                      ),
                      hintText: "E-Mail",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      } else if (!GetUtils.isEmail(value)) {
                        return "Invalid Email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: isnotVisible,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        size: 20,
                        color: RColors.smallFontColor,
                      ),
                      suffixIcon: _buildVisibleIconButton(),
                      hintText: "password",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      } else if (value.length < 8) {
                        return "Password must be at least 8 characters long";
                      } else if (!RegExp(r'(?=.*[A-Z])')
                          .hasMatch(value)) {
                        return "Password must contain at least one uppercase letter";
                      } else if (!RegExp(r'(?=.*[0-9])')
                          .hasMatch(value)) {
                        return "Password must contain at least one number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  CustomDropDownMenu(
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value;
                      });
                    },
                    selectedValue: selectedRole,
                  ),
                  SizedBox(height: 30),
                  SavePasswordForgetButton(isLoginPage: false),
                  SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_globalKey.currentState!.validate()) {
                          signUp();
                        }
                      },
                      child: Text("REQUEST ACCESS"),
                    ),
                  ),
                  SizedBox(height: 20),
                  //Button
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: RColors.blueButtonColors,
                      ),
                      onPressed: () {
                        Get.to(
                          () => SingInScreen(),
                          transition: Transition.rightToLeft,
                          duration: Duration(
                            milliseconds: 750,
                          ),
                        );
                      },
                      child: Text("Already have an account? LOG IN"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVisibleIconButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          isnotVisible = !isnotVisible;
        });
      },
      icon: isnotVisible
          ? Icon(Icons.visibility_off, color: RColors.smallFontColor)
          : Icon(Icons.visibility, color: RColors.smallFontColor),
    );
  }

  // Updated signUp method with error handling
  void signUp() async {
  String username = _userNameTEController.text;
  String email = _emailTEController.text;
  String password = _passwordTEController.text;

  // Pass the username, email, and password to signUpWithEmailAndPassword
  User? user = await _auth.signUpWithEmailAndPassword(email, password, username);

  if (user != null) {
    String userId = user.uid;
    try {
      await _dbRef.child("pending_users").child(userId).set({
        "username": username,
        "email": email,
        "role": selectedRole,
        "status": "pending"
      });
      print("Data written successfully");

      Get.to(() => SingInScreen());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: RColors.snackBarColorR,
          content: Text(
            "Access request submitted. Waiting for approval",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white, fontSize: 12),
          ),
        ),
      );
    } catch (e) {
      print("Error writing data: $e");
    }
  }
}

}
