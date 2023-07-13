import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_project_flutter/components/alert_message.dart';
import 'package:test_project_flutter/constants/exports.dart';
import 'package:test_project_flutter/models/user.dart';
import 'package:test_project_flutter/services/user_service.dart';

class UserCreateScreen extends StatefulWidget {
  const UserCreateScreen({super.key});

  @override
  State<UserCreateScreen> createState() => _UserCreateScreenState();
}

class _UserCreateScreenState extends State<UserCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  late UserService _userService;
  late bool _alertMessageState;

  TextEditingController fullnameInput = TextEditingController();
  TextEditingController emailInput = TextEditingController();
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    _userService = UserService();
    _initializeDatabase();
    fullnameInput.text = '';
    emailInput.text = '';
    dateInput.text = '';
    _alertMessageState = false;
    super.initState();
  }

  Future<void> _initializeDatabase() async {
    await _userService.initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create User')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
              const SizedBox(height: 10),
              buildForm(context),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: <Color>[
                          Colors.blue,
                          Colors.lightBlue
                        ])),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, USER_LIST_SCREEN);
                        },
                        child: const Row(
                          children: [Icon(Icons.arrow_back), Text('Return')],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: 'Name'),
            keyboardType: TextInputType.name,
            controller: fullnameInput,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please, type your name';
              }
              return null;
            },
            onSaved: (value) {
              fullnameInput.text = value!;
            },
          ),
          const SizedBox(height: 50),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            controller: emailInput,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please, type your email';
              }
              return null;
            },
            onSaved: (value) {
              emailInput.text = value!;
            },
          ),
          const SizedBox(height: 50),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Date'),
                  keyboardType: TextInputType.datetime,
                  controller: dateInput,
                  readOnly: true,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100));

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(pickedDate);

                    setState(() {
                      dateInput.text = formattedDate;
                    });
                  }
                },
                child: const Icon(Icons.calendar_month),
              )
            ],
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      print('okkk');
                      try {
                        await _userService.addUser(User(
                            name: fullnameInput.text,
                            email: emailInput.text,
                            date: dateInput.text));
                        setState(() {
                          _alertMessageState = true;
                          fullnameInput.clear();
                          emailInput.clear();
                          dateInput.clear();
                        });
                      } catch (e) {
                        setState(() {
                          _alertMessageState = false;
                        });
                      }
                    }
                  },
                  child: const Row(
                    children: [Icon(Icons.save), Text('Save')],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          _alertMessageState
              ? const AlertMessage(message: 'Success!', icon: Icons.check)
              : const SizedBox()
        ],
      ),
    );
  }
}
