import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maktrack/presentation/pages/screen/Boss%20Project%20Details/boss_project_details.dart';
import 'package:maktrack/presentation/widgets/bar_chart_widget.dart';
import 'package:maktrack/presentation/widgets/project_container.dart';
import 'package:maktrack/presentation/widgets/text_widget.dart';
import 'package:maktrack/presentation/widgets/top_bar_widget.dart';
import 'package:maktrack/presentation/widgets/total_container.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class BossDashBoard extends StatelessWidget {
  const BossDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<double> completedProjects = [
      3000,
      4500,
      2700,
      3500
    ]; // Completed Revenue
    final List<double> ongoingProjects = [
      1800,
      2500,
      1500,
      2200
    ]; // Ongoing Revenue
    final List<String> departmentName = [
      'FLUTTER',
      'MERN',
      'LARAVEL',
      'PHP',
    ];
    final List<List<String>> departmentIcon = [
      [
        'assets/Icons/flutter 1.png',
        'assets/Icons/flutter 2.png',
        'assets/Icons/flutter 3.png',
        'assets/Icons/flutter 4.png',
      ],
      [
        'assets/Icons/mern 1.png',
        'assets/Icons/mern 2.png',
        'assets/Icons/mern 3.png',
        'assets/Icons/mern 4.png',
      ],
      [
        'assets/Icons/laravel 1.png',
        'assets/Icons/laravel 2.png',
        'assets/Icons/laravel 3.png',
        'assets/Icons/laravel 4.png',
      ],
      [
        'assets/Icons/php 1.png',
        'assets/Icons/php 2.png',
        'assets/Icons/php 3.png',
        'assets/Icons/php 4.png',
      ],
    ];

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        bool? shouldExit = await showDialog(
          context: context,
          barrierDismissible: false, // User must choose Yes or No
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Are you sure?"),
              content: Text("Do you want to exit the app?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Stay in the app
                  },
                  child: Text("No"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Close the app
                  },
                  child: Text("Yes"),
                ),
              ],
            );
          },
        );

        if (shouldExit == true) {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        }
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 25, right: 20, top: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                  height: MediaQuery.sizeOf(context).height > 800
                      ? MediaQuery.sizeOf(context).height * 0.42
                      : MediaQuery.sizeOf(context).height * 0.49,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopBarWidget(
                        text: 'Dashboard',
                        optionalWidgets: [
                          Icon(
                            Icons.notifications_none,
                            size: 30,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextWidget(
                        text: 'Project Summary',
                        size: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: departmentName.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio: 1.7,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => BossProjectDetails());
                              },
                              child: ProjectContainer(
                                imageIndex: index,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: TextWidget(
                                        text: departmentName[index],
                                        size: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: departmentIcon[index]
                                            .map(
                                              (icon) => Image.asset(
                                                icon,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.04,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.06,
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Bar Chart
                buildBarChart(
                    departmentName, completedProjects, ongoingProjects),

                const SizedBox(height: 15),
                Divider(
                  thickness: 0.5, // Change this for a thicker line
                  color: Colors.grey[400], // Change color
                ),

                // Total Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TotalContainer(
                        text: 'Total amount:',
                        projectNumber: '\$ 123',
                      ),
                    ),
                    Expanded(
                      child: TotalContainer(
                        text: 'Total Delivered:',
                        projectNumber: '\$423',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
