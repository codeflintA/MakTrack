import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:maktrack/domain/entities/asset_path.dart';
import 'package:maktrack/presentation/state_managment/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  // final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black54,
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15),
                  child: Container(
                    color: Colors.black54,
                    child: Image.asset(
                      AssetPath.basePathTitle,
                      height: 250,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
            LottieBuilder.asset("assets/lottie/Animation - 1741059464680.json"),
          ],
        ),
      ),
    );
  }
}
