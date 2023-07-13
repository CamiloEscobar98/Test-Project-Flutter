import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:test_project_flutter/services/user_service.dart';

class UserCreateScreen extends StatefulWidget {
  const UserCreateScreen({super.key});

  @override
  State<UserCreateScreen> createState() => _UserCreateScreenState();
}

class _UserCreateScreenState extends State<UserCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  late UserService _userService;

  String _fullname = '';
  String _date = '';

  @override
  void initState() {
    super.initState();
    _userService = UserService();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    await _userService.initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
                text: const TextSpan(
                  text: 'Create a New User',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                textAlign: TextAlign.start),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    keyboardType: TextInputType.name,
                    controller: TextEditingController(text: _fullname),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please, type your name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _fullname = value!;
                    },
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Date'),
                    keyboardType: TextInputType.datetime,
                    controller: TextEditingController(text: _date),
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please, type your birthdate';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // DatePicker.showDatePicker(
                      //   context,
                      //   showTitleActions: true,
                      //   onConfirm: (date) {
                      //     setState(() {
                      //       _date = date.toString();
                      //     });
                      //   },
                      // );
                    },
                    child: const Text('Select Birthdate'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
