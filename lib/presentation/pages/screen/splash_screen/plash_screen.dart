import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maktrack/domain/entities/asset_path.dart';
import 'package:maktrack/presentation/state_managment/splash_controller.dart';

class PlashScreen extends StatelessWidget {
  PlashScreen({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black54,
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Center(
            child: Image.asset(
              AssetPath.logoPng,
              height: 65,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }
}
