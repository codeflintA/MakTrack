import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maktrack/domain/entities/asset_path.dart';
import 'package:maktrack/presentation/widgets/custom_app_bar.dart';
import 'package:maktrack/presentation/widgets/total_price_widget.dart';

class TaskAddScreen extends StatefulWidget {
  const TaskAddScreen({super.key});

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  final List<Map<String, dynamic>> tasks = [
    {
      "title": "Task 1 ",
      "Total": "Total Project",
      "icon": AssetPath.totalPricePng
    },
    {"title": "Task 2 ", "Total": "In Progress", "icon": AssetPath.clockPng},
    {"title": "Task 3 ", "Total": "NRA", "icon": AssetPath.nrmPng},
    {"title": "Task 4", "Total": "Complete", "icon": AssetPath.completePng},
    {"title": "Task 5", "Total": "Cancel", "icon": AssetPath.canselPng},
    {"title": "Task 6 ", "Total": "Total Target", "icon": AssetPath.targetPng},
    {"title": "Task 7", "Total": "Carry Forward", "icon": AssetPath.carryPng},
  ]
      .map((task) => {
            ...task,
            "amount": "",
            "projects": "",
            "amountController": TextEditingController(),
            "projectsController": TextEditingController(),
          })
      .toList();

  InputDecoration customInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade600),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      filled: true,
      fillColor: Colors.grey.shade100,
    );
  }

  @override
  void dispose() {
    for (var task in tasks) {
      task['amountController'].dispose();
      task['projectsController'].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                text: "Back",
                images: AssetPath.logoPng,
                onPressed: () {
                  Get.back();
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Color(0xffe8edf6),
                      elevation: 10,
                      shadowColor: Colors.grey.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tasks[index]["title"],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TotalPriceWidget(
                              icon: tasks[index]["icon"],
                              text: tasks[index]["Total"] ?? "Unknown",
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: tasks[index]
                                        ['amountController'],
                                    keyboardType: TextInputType.number,
                                    decoration: customInputDecoration("Amount"),
                                    onChanged: (value) {
                                      tasks[index]['amount'] = value;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    controller: tasks[index]
                                        ['projectsController'],
                                    keyboardType: TextInputType.number,
                                    decoration:
                                        customInputDecoration("Projects"),
                                    onChanged: (value) {
                                      tasks[index]['projects'] = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the next screen where the dashboard is
                  },
                  child: const Text("Proceed to Dashboard"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
