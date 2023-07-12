import 'package:flutter/material.dart';
import 'package:test_project_flutter/routes/routes.dart';

void main() {
  runApp(MyApp(
    router: RouterApplication(),
  ));
}

class MyApp extends StatelessWidget {
  final RouterApplication router;
  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      onGenerateRoute: router.generateRoute,
      )
    ;
  }
}
