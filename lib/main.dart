import 'package:flutter/material.dart';
import 'package:we_care/myplans/my_plans.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyPlans(),
    );
  }
}
