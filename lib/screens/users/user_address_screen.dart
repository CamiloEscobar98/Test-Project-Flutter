import 'package:flutter/material.dart';
import 'package:test_project_flutter/models/user.dart';
import 'package:test_project_flutter/services/user_service.dart';

class UserAddressScreen extends StatefulWidget {
  final User user;
  const UserAddressScreen({super.key, required this.user});

  @override
  State<UserAddressScreen> createState() => _UserAddressScreenState();
}

class _UserAddressScreenState extends State<UserAddressScreen> {
  late UserService _userService;

  @override
  void initState() {
    _userService = UserService();
    _initializeDatabase();
    super.initState();
  }

  Future<void> _initializeDatabase() async {
    await _userService.initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.user.name}: Information')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                  text: const TextSpan(
                    text: 'Information about User',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  textAlign: TextAlign.start),
            ],
          ),
        ),
      ),
    );
  }
}
