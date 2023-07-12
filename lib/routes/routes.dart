import 'package:flutter/material.dart';
import 'package:test_project_flutter/screens/exports.dart';
import 'package:test_project_flutter/constants/exports.dart';

class RouterApplication {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case USER_SCREEN:
        return MaterialPageRoute(builder: (_) => const UserListScreen());
      default:
        return MaterialPageRoute(builder: (_) => const UserListScreen());
    }
  }
}
