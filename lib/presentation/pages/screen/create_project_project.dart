import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maktrack/domain/entities/asset_path.dart';
import 'package:maktrack/domain/entities/color.dart';
import 'package:maktrack/presentation/pages/screen/view_task_screen.dart';
import 'package:maktrack/presentation/widgets/custom_app_bar.dart';
import 'package:maktrack/presentation/widgets/total_price_widget.dart';

class CreateNewProject extends StatefulWidget {
  const CreateNewProject({super.key});

  @override
  State<CreateNewProject> createState() => _CreateNewProjectState();
}

class _CreateNewProjectState extends State<CreateNewProject> {
  final List<Map<String, dynamic>> tasks = [
    {
      "title": "Create a new project",
      "Total": "Project Details",
    },
  ]
      .map((task) => {
            ...task,
            "ProjectNameController": TextEditingController(),
            "ProjectTypeController": TextEditingController(),
            "ProjectProgressController": TextEditingController(),
            "AssignDateController": TextEditingController(),
            "ProjectTimelineController": TextEditingController(),
          })
      .toList();

  /// **Date Picker Function**
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        controller.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  physics: const BouncingScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: RColors.bgColorColorS,
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
                              text: tasks[index]["Total"] ?? "Unknown",
                            ),
                            const SizedBox(height: 10),
                            Column(
                              children: [
                                TextFormField(
                                  controller: tasks[index]
                                      ['ProjectNameController'],
                                  decoration:
                                      customInputDecoration("Project Name"),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: tasks[index]
                                      ['ProjectTypeController'],
                                  decoration:
                                      customInputDecoration("Project Type"),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: tasks[index]
                                      ['ProjectProgressController'],
                                  keyboardType: TextInputType.number,
                                  decoration: customInputDecoration(
                                      "Project Progress (%)"),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: tasks[index]
                                      ['AssignDateController'],
                                  readOnly: true,
                                  decoration: customInputDecoration(
                                    "Assign Date",
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.calendar_today),
                                      onPressed: () => _selectDate(context,
                                          tasks[index]['AssignDateController']),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: tasks[index]
                                      ['ProjectTimelineController'],
                                  readOnly: true,
                                  decoration: customInputDecoration(
                                    "Project Timeline",
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.calendar_today),
                                      onPressed: () => _selectDate(
                                          context,
                                          tasks[index]
                                              ['ProjectTimelineController']),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
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
                    Get.to(() => ViewTaskScreen());
                  },
                  child: const Text("Save Project"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration customInputDecoration(String hint, {Widget? suffixIcon}) {
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
      suffixIcon: suffixIcon,
    );
  }

  @override
  void dispose() {
    for (var task in tasks) {
      task['ProjectNameController'].dispose();
      task['ProjectTypeController'].dispose();
      task['ProjectProgressController'].dispose();
      task['AssignDateController'].dispose();
      task['ProjectTimelineController'].dispose();
    }
    super.dispose();
  }
}
