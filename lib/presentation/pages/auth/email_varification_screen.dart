import 'dart:async' as async;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maktrack/domain/entities/asset_path.dart';
import 'package:maktrack/domain/entities/color.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/sing_up_title.dart';
import 'otp_verification_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late async.Timer timer;

  @override
  void initState() {
    super.initState();
  }

  final _emailTEController = TextEditingController();
  // ignore: unused_field
  final _phoneNumberTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: RColors.bgColorColorS,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                CustomAppBar(
                  text: 'Back',
                  images: AssetPath.logoPng,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 100),
                SingUpAndTitle(
                  title: 'Email Verification ',
                  title2:
                      "Enter your email to receive an OTP and reset your password.",
                ),
                const SizedBox(height: 100),
                TextFormField(
                  controller: _emailTEController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
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
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _emailTEController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                      size: 20,
                      color: RColors.smallFontColor,
                    ),
                    hintText: "Phone Number",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your Phone Number";
                    } else if (!GetUtils.isEmail(value)) {
                      return "Invalid Phone Number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 220),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      emailVerify();
                    },
                    child: const Text("Verify & Proceed"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }

  void emailVerify() async {
    if (_globalKey.currentState!.validate()) {
      final email = _emailTEController.text.trim();
      if (GetUtils.isEmail(email)) {
        try {
          User? currentUser = _auth.currentUser;

          if (currentUser == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Please sign up first.",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                ),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          await currentUser.sendEmailVerification();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Verification email sent. Please check your inbox.",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 12,
                      color: Colors.white,
                    ),
              ),
              backgroundColor: Colors.green,
            ),
          );

          Get.to(
            () => OtpVerificationScreen(),
            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 750),
          );
        } catch (e) {
          // Handle errors, e.g. network or Firebase errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Error sending verification email",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 12,
                      color: Colors.white,
                    ),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Invalid email format.",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 12,
                    color: Colors.white,
                  ),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
