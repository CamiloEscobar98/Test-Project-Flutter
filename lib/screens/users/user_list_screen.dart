import 'package:flutter/material.dart';
import 'package:test_project_flutter/models/user.dart';
import 'package:test_project_flutter/services/user_service.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late UserService _userService;
  List<User> _userList = [];

  @override
  void initState() {
    _userService = UserService();
    _initializeDatabase();
    _loadUserList();
    super.initState();
  }

  Future<void> _initializeDatabase() async {
    await _userService.initDatabase();
  }

  Future<void> _loadUserList() async {
    final userList = await _userService.getAllUsers();
    setState(() {
      _userList = userList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: const TextSpan(
                  text: 'Users List',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                textAlign: TextAlign.start),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: <Color>[Colors.blue, Colors.lightBlue])),
                    ),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          textStyle: const TextStyle(fontSize: 12)),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'users/create');
                      },
                      child: const Text('Register'))
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _userList.length,
                itemBuilder: (context, index) {
                  final user = _userList[index];
                  return ListTile(
                    title: Text(user.name),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
