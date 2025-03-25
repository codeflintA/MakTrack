// import 'dart:async';
// import 'package:get/get.dart';
// import 'package:maktrack/presentation/pages/screen/three_screen/onboarding_page.dart';

// class SplashController extends GetxController {
//   var showLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     startProcess();
//   }

//   void startProcess() {
//     Future.delayed(const Duration(seconds: 3), () {
//       showLoading.value = true;

//       Future.delayed(const Duration(seconds: 1), () {
//         Get.offAll(
//           () => const ThreeScreenPage(),
//           transition: Transition.rightToLeft,
//           duration: const Duration(milliseconds: 750),
//         );
//       });
//     });
//   }
// }

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maktrack/presentation/pages/auth/sing_in_screen.dart';
import 'package:maktrack/presentation/pages/screen/BossDashBoard/boss_dash_board.dart';
import 'package:maktrack/presentation/pages/screen/onboarding/onboarding_screen.dart';
import 'package:maktrack/presentation/pages/screen/splash_screen/plash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    navigateUser(); // Function call here
  }

  Future<void> navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool("isFirstTime") ?? true;

    if (isFirstTime) {
      // First time user -> Show Onboarding Screen
      await prefs.setBool("isFirstTime", false);
      Get.offAll(() => OnboardingPage());
    } else {
      // Check if user is logged in
      User? user = _auth.currentUser;
      if (user != null) {
        // User already logged in -> Navigate to Dashboard
        Get.offAll(() => BossDashBoard());
      } else {
        // User not logged in -> Show Login Screen
        Get.offAll(() => SingInScreen());
      }
    }
  }
}
