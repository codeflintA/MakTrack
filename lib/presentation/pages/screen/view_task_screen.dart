import 'package:flutter/material.dart';
import 'package:maktrack/domain/entities/asset_path.dart';
import 'package:maktrack/presentation/widgets/selected_tab.dart';
import 'package:maktrack/presentation/widgets/top_bar_widget.dart';
import '../../widgets/project_tab_card.dart';

class ViewTaskScreen extends StatefulWidget {
  const ViewTaskScreen({
    super.key,
  });

  @override
  State<ViewTaskScreen> createState() => _ViewTaskScreenState();
}

class _ViewTaskScreenState extends State<ViewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xfff5f4fa),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              children: [
                TopBarWidget(
                  text: "Projects",
                  optionalWidgets: [
                    Image.asset(
                      AssetPath.zoomPng,
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(width: 20),
                    Image.asset(
                      AssetPath.menuPng,
                      height: 30,
                      width: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SelectedTab(),
                const SizedBox(height: 20),
                ProjectTabCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
