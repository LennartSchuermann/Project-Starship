// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:tankwatcher/Screens/LoadingScreen.dart';
import 'package:tankwatcher/Utils/scraper.dart';
import 'package:tankwatcher/design.dart';
import 'Screens/HomeScreen.dart';

void main() {
  runApp(const TankWatcherApp());
}

ThemeData _lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.white,
  brightness: Brightness.dark,
  focusColor: Colors.black,
  inputDecorationTheme: const InputDecorationTheme(
      //focusColor: Colors.black,
      ),
);

ThemeData _darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  backgroundColor: Colors.black,
  focusColor: Colors.white,
  brightness: Brightness.light,
  inputDecorationTheme: const InputDecorationTheme(
      //focusColor: Colors.white,
      ),
);

class TankWatcherApp extends StatelessWidget {
  const TankWatcherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<List>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData &&
              snapshot.data!.isNotEmpty &&
              snapshot.data!.length >= 5) {
            return HomeScreen(
              closureData: snapshot.data![0],
              starshipData: snapshot.data![1],
              superHeavyData: snapshot.data![2],
              activityLogData: snapshot.data![3],
              eventsData: snapshot.data![4],
            );
          } else {
            return const LoadingScreen();
          }
        },
      ),
    );
  }
}
