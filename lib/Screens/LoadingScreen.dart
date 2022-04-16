// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:tankwatcher/design.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: kDefaultPadding * 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                kAppName.split(" ")[0],
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: kTitleSize,
                  fontWeight: FontWeight.w100,
                  color: Theme.of(context).focusColor,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                kAppName.split(" ")[1],
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: kTitleSize,
                  fontWeight: FontWeight.w100,
                  color: Theme.of(context).focusColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: kDefaultPadding * 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 48.0,
                height: 48.0,
                child: CircularProgressIndicator(
                  color: Theme.of(context).focusColor,
                  strokeWidth: 1.2,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
