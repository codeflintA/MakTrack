import 'package:flutter/material.dart';

class AnimatedTaskListTabs extends StatefulWidget {
  @override
  _AnimatedTaskListTabsState createState() => _AnimatedTaskListTabsState();
}

class _AnimatedTaskListTabsState extends State<AnimatedTaskListTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> _tabs = ['Task List', 'File', 'Comment'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
          labelColor: Colors.deepPurple,
          unselectedLabelColor: Colors.black,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            // ignore: deprecated_member_use
            color: Colors.deepPurple.withOpacity(0.2),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _tabs.map((tab) {
              return Center(
                child: Text(
                  '$tab Content',
                  style: TextStyle(fontSize: 24),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
