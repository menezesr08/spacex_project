import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacex_project/UI/upcoming_launches_data.dart';
import 'package:spacex_project/UI/screens/upcoming_launches_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UpcomingLaunchesData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const UpcomingLaunchesScreen(),
      ),
    );
  }
}
