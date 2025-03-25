import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maktrack/domain/entities/asset_path.dart';
import 'package:maktrack/presentation/pages/screen/Leader_project_Deails/leader_project_details.dart';
import 'package:maktrack/presentation/pages/screen/ProjectDetails/super_admin_project_details.dart';
import 'package:maktrack/presentation/pages/screen/view_task_screen.dart';

class BottomController extends GetxController {
  RxInt selectedIndex = 0.obs;

  final List<Widget> pages = [
    LeaderProjectDetails(),
    LeaderProjectDetails(),
    ViewTaskScreen(),
    const Center(child: Text("Send Page")),
    const Center(child: Text("Profile Page")),
  ];

  RxList<String> navIcons = [
    AssetPath.basePathListImage,
    AssetPath.basePathDocFileImage,
    AssetPath.basePathSendImage,
    AssetPath.basePathAvatarImage,
  ].obs;

  void changeIndex(int index) {
    print("_______________${selectedIndex.value}__________________");
    selectedIndex.value = index;
  }
}
