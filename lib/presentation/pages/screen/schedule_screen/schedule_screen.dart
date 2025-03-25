import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maktrack/domain/entities/color.dart';
import 'package:maktrack/model/task.dart';
import 'package:maktrack/presentation/pages/screen/schedule_add_task_screen/add_task_schedule_screen.dart';
import '../../../state_managment/task_controller.dart';
import 'widgets/task_tile.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe8edf6),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat.yMMMMd().format(selectedDate),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.black54,
                                  ),
                            ),
                            Text(
                              getFormattedDate(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Colors.black,
                                  ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Get.to(() => AddTaskScheduleScreen());
                            _taskController.getTaskList();
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: RColors.blueButtonColors,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "+ Add Task",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: DatePicker(
                      DateTime.now().subtract(Duration(days: 2)),
                      height: 110,
                      width: 80,
                      initialSelectedDate: selectedDate,
                      selectionColor: RColors.blueButtonColors,
                      selectedTextColor: Colors.white,
                      onDateChange: (date) {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(() {
                // Filter tasks based on the selected date
                var filteredTasks = _taskController.taskList.where((task) {
                  // Check if task.date is null or empty
                  if (task.date == null || task.date!.isEmpty) {
                    return false; // Skip task if date is null or empty
                  }
                  DateTime? taskDate;
                  try {
                    taskDate = DateFormat('M/d/yyyy').parse(task.date!);
                  } catch (e) {
                    print('Invalid date format: ${task.date}');
                    return false;
                  }
                  return taskDate.year == selectedDate.year &&
                      taskDate.month == selectedDate.month &&
                      taskDate.day == selectedDate.day;
                }).toList();

                return ListView.builder(
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showBottomSheet(
                                      context, filteredTasks[index]);
                                },
                                child: TaskTile(
                                  task: filteredTasks[index],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context, Task task) {
    // ignore: unnecessary_null_comparison
    if (task == null) {
      print('Task is null');
      return; // Exit early if task is null
    }

    Get.bottomSheet(Container(
      width: double.infinity,
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 6,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Spacer(),
          task.isCompleted == 1
              ? Container()
              : _bottomSheetButton(
                  label: 'Task Completed',
                  onTap: () {
                    Get.back();
                  },
                  color: RColors.blueButtonColors,
                  context: context,
                ),
          SizedBox(
            height: 20,
          ),
          _bottomSheetButton(
            label: 'Deleted',
            onTap: () {
              _taskController.deleteTask(task);
              _taskController.getTaskList(); // Refresh the task list
              Get.back();
            },
            color: RColors.snackBarColorR,
            context: context,
          ),
          SizedBox(
            height: 25,
          ),
          _bottomSheetButton(
            label: 'Close',
            onTap: () {
              Get.back();
            },
            color: Colors.white,
            isClose: true,
            context: context,
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    ));
  }

  _bottomSheetButton({
    required String label,
    Function()? onTap,
    required Color color,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isClose == true ? Colors.transparent : color,
          border: Border.all(
              width: 1,
              color: isClose == true ? Colors.grey[600]! : Colors.grey[300]!),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isClose == true ? Colors.black : Colors.white,
                ),
          ),
        ),
      ),
    );
  }

  String getFormattedDate() {
    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(Duration(days: 1));
    DateTime yesterday = today.subtract(Duration(days: 1));

    if (selectedDate.year == today.year &&
        selectedDate.month == today.month &&
        selectedDate.day == today.day) {
      return "Today";
    } else if (selectedDate.year == tomorrow.year &&
        selectedDate.month == tomorrow.month &&
        selectedDate.day == tomorrow.day) {
      return "Tomorrow";
    } else if (selectedDate.year == yesterday.year &&
        selectedDate.month == yesterday.month &&
        selectedDate.day == yesterday.day) {
      return "Yesterday";
    } else {
      return DateFormat.EEEE().format(selectedDate);
    }
  }
}
