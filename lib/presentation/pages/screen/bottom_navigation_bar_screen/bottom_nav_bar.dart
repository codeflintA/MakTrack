import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maktrack/domain/entities/color.dart';
import 'package:maktrack/presentation/pages/leader_input_screen.dart';
import 'package:maktrack/presentation/pages/screen/create_project_project.dart';
import 'package:maktrack/presentation/state_managment/bottom_controller.dart';

class Bottom extends StatelessWidget {
  Bottom({super.key});

  final BottomController controller = Get.put(BottomController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.pages[controller.selectedIndex.value],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Background color of BottomAppBar
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 3,
              ),
            ],
          ),
          child: BottomAppBar(
            color: Colors
                .transparent, // Make it transparent to avoid double layering of colors
            shape: const CircularNotchedRectangle(),
            notchMargin: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(controller.navIcons.length, (index) {
                  return IconButton(
                    onPressed: () => controller.changeIndex(index),
                    icon: Obx(() => Image.asset(
                          controller.navIcons[index],
                          color: controller.selectedIndex.value == index
                              ? RColors.blueButtonColors
                              : null,
                        )),
                  );
                }),                             
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => CreateNewProject());
          },
          backgroundColor: RColors.blueButtonColors,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            size: 32,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
