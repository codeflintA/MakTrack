import 'package:flutter/material.dart';
import 'package:maktrack/presentation/widgets/bar_chart_widget.dart';
import 'package:maktrack/presentation/widgets/project_container.dart';
import 'package:maktrack/presentation/widgets/text_widget.dart';
import 'package:maktrack/presentation/widgets/total_container.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

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

    return Scaffold(
      backgroundColor: Colors.grey[100],
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
                    : MediaQuery.sizeOf(context).height * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: 'DashBoard',
                          size: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        const Icon(
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
                          return ProjectContainer(
                            imageIndex: index,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: departmentName[index],
                                  size: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: departmentIcon[index].map((icon) {
                                    return Image.asset(
                                      icon,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.04,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.06,
                                    );
                                  }).toList(),
                                ),
                              ],
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
              buildBarChart(departmentName, completedProjects, ongoingProjects),

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
                      text: 'Total Project amount:',
                      projectNumber: '\$ 123',
                    ),
                  ),
                  Expanded(
                    child: TotalContainer(
                      text: 'Total Task Activity:',
                      projectNumber: '423 Task',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
