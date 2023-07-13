import 'package:flutter/material.dart';
import 'package:test_project_flutter/models/user.dart';
import 'package:test_project_flutter/screens/exports.dart';
import 'package:test_project_flutter/constants/exports.dart';

class RouterApplication {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case USER_LIST_SCREEN:
        return MaterialPageRoute(builder: (_) => const UserListScreen());
      case USER_CREATE_SCREEN:
        return MaterialPageRoute(builder: (_) => const UserCreateScreen());
      case USER_INFO_SCREEN:
        final User user = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => UserAddressScreen(user: user));
      default:
        return MaterialPageRoute(builder: (_) => const UserListScreen());
    }
  }
}
