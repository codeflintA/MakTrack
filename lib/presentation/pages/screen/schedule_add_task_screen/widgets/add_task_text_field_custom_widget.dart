import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maktrack/model/task.dart';
import 'package:maktrack/presentation/state_managment/task_controller.dart';
import '../../../../../domain/entities/color.dart';
import 'color_container_custom.dart';

class AddTaskTextFieldCustomWidget extends StatefulWidget {
  const AddTaskTextFieldCustomWidget({
    super.key,
  });

  @override
  State<AddTaskTextFieldCustomWidget> createState() =>
      _AddTaskTextFieldCustomWidgetState();
}

class _AddTaskTextFieldCustomWidgetState
    extends State<AddTaskTextFieldCustomWidget> {
  TaskController taskController = Get.put(TaskController());
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  int _isSelected = 0;

  addTask() async {
    int value = await taskController.addTask(
        task: Task(
      title: titleController.text,
      note: noteController.text,
      date: DateFormat.yMd().format(selectedDate),
      startTime: startTime,
      endTime: endTime,
      reminder: selectedReminder,
      repeat: selectedRepeat,
      color: _isSelected,
      isCompleted: 0,
    ));

    print("My value is $value");
  }

  validate() {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      addTask();
      Get.back();
    } else if (titleController.text.isEmpty || noteController.text.isEmpty) {
      Get.snackbar("Required", "Please fill all the fields!",
          messageText: Text(
            "Please fill all the fields!",
            style: TextStyle(color: Colors.grey[200]),
          ),
          titleText: Text(
            "Required",
            style: TextStyle(color: Colors.grey[200]),
          ),
          snackPosition: SnackPosition.TOP,
          backgroundColor: RColors.blueButtonColors,
          icon: Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    }
  }

  // Date time picker
  DateTime selectedDate = DateTime.now();

  // start time and end time
  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String endTime = "12.40 PM";

// Date text field function to get date from user
  getDateFormUser() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedDate = value;
        });
      }
    });
  }

  // Start time to get time form user
  getStartTimeFormUser() {
    showTimePicker(
      barrierDismissible: false,
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          startTime = value.format(context);
        });
      }
    });
  }

  // End time to get time form user
  getEndTimeFormUser() {
    showTimePicker(
      barrierDismissible: false,
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          endTime = value.format(context);
        });
      }
    });
  }

  // Selected Reminder
  int selectedReminder = 5;
  List<int> reminders = [5, 10, 15, 20, 25, 30];

  // Selected Repeat
  String selectedRepeat = "None";
  List<String> repeats = ["None", "Daily", "Weekly", "Monthly"];

  @override
  Widget build(BuildContext context) {
    return Column(spacing: 15, children: [
      // Title text field
      Column(
        spacing: 7,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Title"),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                hintText: "Enter Title", border: OutlineInputBorder()),
          ),
        ],
      ),

      // Note text field
      Column(
        spacing: 7,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Note"),
          TextField(
            controller: noteController,
            decoration: InputDecoration(
                hintText: "Enter Note", border: OutlineInputBorder()),
          ),
        ],
      ),

      // Date text field
      Column(
        spacing: 7,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Date"),
          TextField(
            // ignore: unnecessary_null_comparison
            readOnly: widget == null ? false : true,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      getDateFormUser();
                    },
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.grey,
                    )),
                hintText: DateFormat.yMd().format(selectedDate),
                border: OutlineInputBorder()),
          ),
        ],
      ),

      // Time text field
      Row(
        spacing: 10,
        children: [
          // Start time text field
          Expanded(
            child: Column(
              spacing: 7,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Start Time"),
                TextField(
                  // ignore: unnecessary_null_comparison
                  readOnly: widget == null ? false : true,
                  decoration: InputDecoration(
                      hintText: startTime,
                      suffixIcon: IconButton(
                        onPressed: () {
                          getStartTimeFormUser();
                        },
                        icon: Icon(
                          Icons.access_time_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
          // End time text field
          Expanded(
            child: Column(
              spacing: 7,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("End Time"),
                TextField(
                  decoration: InputDecoration(
                      hintText: endTime,
                      suffixIcon: IconButton(
                        onPressed: () {
                          getEndTimeFormUser();
                        },
                        icon: Icon(
                          Icons.access_time_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
        ],
      ),

      // Reminder text field
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 7,
        children: [
          Text("Reminder"),
          TextField(
            decoration: InputDecoration(
                suffixIcon: DropdownButton(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                  underline: Container(
                    color: Colors.white,
                  ),
                  value: reminders.contains(selectedReminder)
                      ? selectedReminder.toString()
                      : null,
                  items: reminders.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text("$value"),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        selectedReminder = int.parse(value);
                      });
                    }
                  },
                ),
                border: OutlineInputBorder(),
                hintText: "$selectedReminder minutes early"),
          ),
        ],
      ),

      // Repeat text field
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 7,
        children: [
          Text("Repeat"),
          TextField(
            decoration: InputDecoration(
              suffixIcon: DropdownButton(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
                underline: Container(
                  color: Colors.white,
                ),
                value: repeats.contains(selectedRepeat) ? selectedRepeat : null,
                items: repeats.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedRepeat = newValue;
                    });
                  }
                },
              ),
              border: OutlineInputBorder(),
              hintText: ("$selectedRepeat"),
            ),
          )
        ],
      ),

      SizedBox(height: 10),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Color selection
          Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Color",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (int index) {
                  return ColorContainerCustom(
                    color: index == 0
                        ? RColors.snackBarColorR
                        : index == 1
                            ? RColors.snackBarColorS
                            : RColors.blackButtonColor2,
                    onTap: () {
                      setState(() {
                        _isSelected = index;
                        print("$index");
                      });
                    },
                    child: _isSelected == index
                        ? Icon(
                            Icons.done,
                            color: Colors.white,
                          )
                        : null,
                  );
                }),
              ),
            ],
          ),

          // Create task button
          GestureDetector(
            onTap: () {
              validate();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: RColors.blueButtonColors,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Create Task",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ),
        ],
      )
    ]);
  }
}
