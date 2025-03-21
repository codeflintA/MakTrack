import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:maktrack/domain/entities/asset_path.dart';
import 'package:maktrack/domain/entities/color.dart';
import 'package:maktrack/presentation/pages/auth/set_password_screen.dart';
import 'package:maktrack/presentation/widgets/custom_app_bar.dart';
import 'package:maktrack/presentation/widgets/sing_up_title.dart';
class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _otpTEController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool isButtonDisabled = false;
  String resendText = "Resend OTP";
  Timer? _timer;
  int _countdown = 30;
  @override
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
                const SizedBox(
                  height: 10,
                ),
                CustomAppBar(
                  text: 'Back',
                  images: AssetPath.logoPng,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 100,
                ),
                SingUpAndTitle(
                  title: 'OTP Verification ',
                  title2:
                      "Enter the one-time password (OTP) to complete your verification.",
                ),
                const SizedBox(height: 100),
                OtpTextField(
                  numberOfFields: 5,
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {
                    if (code.length == 5) {
                      if (!RegExp(r'^[0-9]{5}$').hasMatch(code)) {
                        log("OTP must only contain numbers");
                      } else {
                        log("OTP is valid: $code");
                      }
                    } else {
                      print("OTP must be 5 digits long");
                    }
                  },
                ),

                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      if(_globalKey.currentState!.validate()){
                        Get.to(
                              () => SetPasswordScreen(),
                          transition: Transition.rightToLeft,
                          duration: Duration(milliseconds: 750),
                        );
                      }
                    },
                    child: const Text("SET Password"),
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: isButtonDisabled ? null : _startTimer,
                    child: Text(
                      resendText,
                      style: TextStyle(
                        color: isButtonDisabled ? Colors.red : Colors.blue,
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

  @override
  void dispose() {
    _timer?.cancel();
    _otpTEController.dispose();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      isButtonDisabled = true;
    });

    // Start a countdown from 30 seconds
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown == 0) {
        setState(() {
          isButtonDisabled = false;
          resendText = "Resend OTP";
        });
        _timer?.cancel();
      } else {
        setState(() {
          _countdown--;
          resendText = "Resend $_countdown sec";
        });
      }
    });
  }
}
