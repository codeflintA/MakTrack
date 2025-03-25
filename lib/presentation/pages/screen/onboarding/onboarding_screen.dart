import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maktrack/presentation/pages/screen/login&signup_button_screen/smart_task_management.dart';
import 'package:maktrack/presentation/state_managment/onboarding_controller.dart';
import 'package:maktrack/presentation/state_managment/splash_controller.dart';
import 'widget/onboarding1.dart';
import 'widget/onboarding2.dart';
import 'widget/onboarding3.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final controllers = Get.put(SplashController());
    final controller = Get.put(OnboardingController());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        return Future(() => true);
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment(0.90, 0.90),
            children: [
              PageView(
                controller: controller.pageController,
                onPageChanged: (index) {
                  controller.onLastPage.value = (index == 2);
                },
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/onboarding/backgroundImage1.png"),
                          fit: BoxFit.cover),
                      color: Color(0xff39459b),
                    ), // Background color for page 1
                    child: const Onboarding1(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/onboarding/backgroundImage2.png"),
                          fit: BoxFit.cover),
                      color: Color(0xfff3e6d6),
                    ), // Background color for page 2
                    child: const Onboarding2(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffd1dfd2),
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/onboarding/backgroundImage3.png"),
                          fit: BoxFit.cover),
                    ), // Background color for page 3
                    child: const Onboarding3(),
                  ),
                ],
              ),
              // Container(
              //   margin: EdgeInsets.only(right: 10),
              //   alignment: Alignment.topRight,
              //   child: CustomText(
              //     tName: "skip",
              //     fSize: 18,
              //     color: Colors.black,
              //     lSpacing: 2,
              //     onTap: () {
              //       controller.pageController.jumpToPage(2);
              //     },
              //   ),
              // ),
              // Container(
              //   alignment: const Alignment(2, 0.6),
              //   child: SmoothPageIndicator(
              //     controller: controller.pageController,
              //     count: 3,
              //     effect: WormEffect(
              //         dotHeight: 5,
              //         dotWidth: 22,
              //         radius: 5,
              //         activeDotColor: Colors.black),
              //   ),
              // ),
              Obx(
                () => controller.onLastPage.value
                    ? GestureDetector(
                        onTap: () => Get.offAll(() => SmartTaskManagement()),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 35, right: 40),
                          height: 45,
                          width: 230,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                              child: Text(
                            "EXPLORE MAKTRACK",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.white),
                          )),
                        ),
                      )
                    : Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.only(bottom: 30, right: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.black,
                        ),
                        child: Center(
                            child: GestureDetector(
                          onTap: () {
                            controller.pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeIn);
                          },
                          child: Icon(
                            Icons.arrow_right_alt,
                            color: Colors.white,
                            size: 30,
                          ),
                        )),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
