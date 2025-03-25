import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maktrack/domain/entities/asset_path.dart';
import 'package:maktrack/domain/entities/color.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maktrack/presentation/state_managment/onboarding_controller.dart';

class SmartTaskManagement extends StatelessWidget {
  const SmartTaskManagement({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingController controller = Get.put(OnboardingController());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        // Show confirmation dialog before popping the screen
        bool shouldPop = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Are you sure?"),
              content: Text("Do you want to exit?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Don't pop the screen
                  },
                  child: Text("No"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Allow pop
                  },
                  child: Text("Yes"),
                ),
              ],
            );
          },
        );
        return shouldPop; // Return true or false based on the user's choice
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Obx(() {
            return controller.isLoading.value
                ? LoadingAnimationWidget.threeRotatingDots(
                    color: RColors.blueButtonColors, size: 50)
                : SingleChildScrollView(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Image.asset(
                                    AssetPath.logoPng,
                                    height: 50,
                                    width: 100,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            Image.asset(
                              AssetPath.taskMangeImage,
                              height: 310,
                              width: double.infinity,
                              fit: BoxFit.fitHeight,
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Smart Task Management",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 33,
                                        ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "This smart tool is designed to help you better manage your task",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: RColors.smallFontColor,
                                        ),
                                  ),
                                  SizedBox(height: 50),
                                  SizedBox(
                                    height: 60,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor:
                                            RColors.blackButtonColor1,
                                      ),
                                      onPressed: () {
                                        controller
                                            .navigateToSingIN(); // Navigate to SignInScreen
                                      },
                                      child: Text("LOG IN"),
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  SizedBox(
                                    height: 60,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            RColors.blueButtonColors,
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: () {
                                        controller
                                            .navigateToSignUp(); // Navigate to SignUpScreen
                                      },
                                      child: Text("SIGN UP"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
