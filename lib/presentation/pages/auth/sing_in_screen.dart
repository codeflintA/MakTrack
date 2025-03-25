import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maktrack/domain/entities/asset_path.dart';
import 'package:maktrack/domain/entities/color.dart';
import 'package:maktrack/firebase_auth_implement/firebase_auth_services.dart';
import 'package:maktrack/presentation/pages/auth/sing_up_screen.dart';
import 'package:maktrack/presentation/pages/screen/BossDashBoard/boss_dash_board.dart';
import 'package:maktrack/presentation/pages/screen/Leader_project_Deails/leader_project_details.dart';
import 'package:maktrack/presentation/pages/screen/ProjectDetails/super_admin_project_details.dart';
import 'package:maktrack/presentation/pages/screen/Boss%20Project%20Details/boss_project_details.dart';
import 'package:maktrack/presentation/pages/screen/login&signup_button_screen/smart_task_management.dart';
import 'package:maktrack/presentation/pages/screen/onboarding/onboarding_screen.dart';
import 'package:maktrack/presentation/state_managment/onboarding_controller.dart';
import 'package:maktrack/presentation/widgets/custom_app_bar.dart';
import 'package:maktrack/presentation/widgets/save_password_forget_button.dart';
import 'package:maktrack/presentation/widgets/sing_up_title.dart';


class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final OnboardingController controller = Get.put(OnboardingController());
  // ignore: unused_field
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final _emailTEController = TextEditingController();
  final _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool isVisible = false;

  

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
                            Get.to(SmartTaskManagement());
                          },
                        ),
                        SizedBox(height: 40),
                        SingUpAndTitle(
                          title: 'Welcome Back!',
                          title2: 'Log in your account & Manage \nYour task',
                        ),
                        SizedBox(height: 60),
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
                        SizedBox(height: 50),
                        TextFormField(
                          controller: _passwordTEController,
                          obscureText: isVisible,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outline_rounded,
                              size: 20,
                              color: RColors.smallFontColor,
                            ),
                            suffixIcon: _buildVisibleIconButton(),
                            hintText: "Password",
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
                        SizedBox(height: 40),
                        SavePasswordForgetButton(isLoginPage: true),
                        SizedBox(height: 30),
                        SizedBox(height: 60),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_globalKey.currentState!.validate()) {
                                sigIn();
                              }
                            },
                            child: Text("LOGIN"),
                          ),
                        ),
                        SizedBox(height: 25),
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
                                () => SingUpScreen(),
                                transition: Transition.rightToLeft,
                                duration: Duration(milliseconds: 750),
                              );
                            },
                            child: Text("Don't have an account? SIGN UP "),
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
          isVisible = !isVisible;
        });
      },
      icon: isVisible
          ? Icon(Icons.visibility_off, color: RColors.smallFontColor)
          : Icon(Icons.visibility, color: RColors.smallFontColor),
    );
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _emailTEController.dispose();
    super.dispose();
  }

  void sigIn() async {
  String email = _emailTEController.text;
  String password = _passwordTEController.text;

  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;

    if (user != null) {
      String uid = user.uid;

      // Check if user is in "users" (Approved users)
      DatabaseReference approvedUserRef =
          FirebaseDatabase.instance.ref("users/$uid");
      DataSnapshot approvedUserSnapshot = await approvedUserRef.get();

      if (approvedUserSnapshot.exists &&
          approvedUserSnapshot.child("status").value.toString() == "approved") {
        
        String role = approvedUserSnapshot.child("role").value.toString();

        // Handle redirection based on role
        switch (role) {
          case 'Boss':
            print("User is a Boss. Redirecting...");
            Get.to(() => BossDashBoard(),
                transition: Transition.rightToLeft,
                duration: Duration(milliseconds: 750));
            break;
          case 'Leader':
          case 'Co-leader':
            print("User is a Leader or Co-leader. Redirecting...");
            Get.to(() => LeaderProjectDetails(),
                transition: Transition.rightToLeft,
                duration: Duration(milliseconds: 750));
            break;
          default:
            print("Unknown role. Please contact support.");
            _showSnackbar("Unknown role. Please contact support.");
            break;
        }
        return;
      }

      // If the user is still pending approval
      DatabaseReference pendingUserRef =
          FirebaseDatabase.instance.ref("pending_users/$uid");
      DataSnapshot pendingUserSnapshot = await pendingUserRef.get();

      if (pendingUserSnapshot.exists) {
        print("User is still pending approval. Logging out.");
        await FirebaseAuth.instance.signOut();
        _showSnackbar(
            "Your account is not approved yet. Please wait for admin approval.");
        return;
      }

      // If the user is a Super Admin
      DatabaseReference superAdminRef =
          FirebaseDatabase.instance.ref("super_admins/$uid");
      DataSnapshot superAdminSnapshot = await superAdminRef.get();

      if (superAdminSnapshot.exists) {
        print("User is a Super Admin. Redirecting...");
        Get.to(() => SuperAdminProjectDetails(),
            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 750));
        return;
      }

      // If user not found in any role or status
      print("User not found in approved users, pending_users, or super_admins.");
      await FirebaseAuth.instance.signOut();
      _showSnackbar("Invalid email or password. Please try again.");
    }
  } catch (e) {
    print("Error: $e");
    _showSnackbar("An error occurred: $e");
  }
}


  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: RColors.snackBarColorR,
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white,
                fontSize: 12,
              ),
        ),
      ),
    );
  }
}
