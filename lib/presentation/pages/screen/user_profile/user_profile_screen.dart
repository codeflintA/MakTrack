import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_upward),
          title: Text(
            "Profile",
            style: TextStyle(
              letterSpacing: 3,
              fontSize: 18,
              color: Colors.deepPurpleAccent,
            ),
          ),
          centerTitle: true,
          actions: [
            Icon(Icons.arrow_back),
            Icon(Icons.settings),
          ],
        ),
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "User Name",
              ),
            ),
            Text("data"),
            Center(
              child: Text("User Profile Screen"),
            ),
          ],
        ));
  }
}
