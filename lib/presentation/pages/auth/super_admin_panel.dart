import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:maktrack/domain/entities/color.dart';

class SuperAdminPanel extends StatefulWidget {
  const SuperAdminPanel({Key? key}) : super(key: key);

  @override
  State<SuperAdminPanel> createState() => _SuperAdminPanelState();
}

class _SuperAdminPanelState extends State<SuperAdminPanel> {
  late DatabaseReference _pendingUsersRef;
  late DatabaseReference _usersRef;
  List<Map<String, dynamic>> _pendingUsers = [];

  @override
  void initState() {
    super.initState();
    _pendingUsersRef = FirebaseDatabase.instance.ref("pending_users");
    _usersRef = FirebaseDatabase.instance.ref("users");
    _fetchPendingUsers();

    // Real-time listener for pending users
    _pendingUsersRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> usersMap =
            event.snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          _pendingUsers = usersMap.entries.map((entry) {
            return {
              'uid': entry.key,
              'email': entry.value['email'],
              'role': entry.value['role'],
              'status': entry.value['status'],
            };
          }).toList();
        });
      } else {
        setState(() {
          _pendingUsers = [];
        });
      }
    });
  }

  // Fetch pending users from Firebase Realtime Database
  void _fetchPendingUsers() async {
    DataSnapshot snapshot = await _pendingUsersRef.get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> usersMap = snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        _pendingUsers = usersMap.entries.map((entry) {
          return {
            'uid': entry.key,
            'email': entry.value['email'],
            'role': entry.value['role'],
            'status': entry.value['status'],
          };
        }).toList();
      });
    }
  }

  // Approve a user by moving them from "pending_users" to "users"
  void _approveUser(String uid, String email, String role) async {
    DatabaseReference pendingUserRef = _pendingUsersRef.child(uid);
    DatabaseReference userRef = _usersRef.child(uid);

    try {
      //  Move user from "pending_users" to "users"
      await userRef.set({
        'email': email,
        'role': role,
        'status': 'approved',
      });

      //  Remove from pending_users
      await pendingUserRef.remove();

      setState(() {
        _pendingUsers.removeWhere((user) => user['uid'] == uid);
      });

      //  Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'User has been approved successfully!',
            style: TextStyle(color: RColors.bgColorColorS),
          ),
          backgroundColor: RColors.blackButtonColor2,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error approving user: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Reject a user (remove from pending_users)
  void _rejectUser(String uid) async {
    DatabaseReference pendingUserRef = _pendingUsersRef.child(uid);

    try {
      //  Remove user from pending_users
      await pendingUserRef.remove();

      setState(() {
        _pendingUsers.removeWhere((user) => user['uid'] == uid);
      });

      //  Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User has been rejected and removed.'),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error rejecting user: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 20,
          children: [
            // Custom Title with Refresh Button
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Super Admin Panel",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: _fetchPendingUsers,
                      child: Icon(
                        Icons.refresh,
                        color: Colors.black,
                      ))
                ],
              ),
            ),

            // Pending Users List
            Expanded(
              child: _pendingUsers.isEmpty
                  ? Center(child: Text('No users to approve.'))
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        itemCount: _pendingUsers.length,
                        itemBuilder: (context, index) {
                          final user = _pendingUsers[index];
                          return Card(
                            color: RColors.blackButtonColor2,
                            margin: EdgeInsets.all(8),
                            child: ListTile(
                              title: Text(
                                user['email'],
                                style: TextStyle(
                                  color: RColors.bgColorColorS,
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: Text(
                                "Role: ${user['role']}",
                                style: TextStyle(
                                  color: RColors.bgColorColorS,
                                  fontSize: 12,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Approve Button ✅
                                  IconButton(
                                    icon: Icon(Icons.check_circle,
                                        color: Colors.green),
                                    onPressed: () => _approveUser(user['uid'],
                                        user['email'], user['role']),
                                  ),
                                  // Reject Button ❌
                                  IconButton(
                                    icon: Icon(Icons.cancel, color: Colors.red),
                                    onPressed: () => _rejectUser(user['uid']),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
