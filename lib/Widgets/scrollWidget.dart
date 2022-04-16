// ignore_for_file: file_names, prefer_const_constructors_in_immutables, non_constant_identifier_names, must_be_immutable, unnecessary_new, deprecated_member_use, avoid_print

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:tankwatcher/Classes/events.dart';
import 'package:tankwatcher/Classes/log.dart';
import 'package:tankwatcher/Classes/starship.dart';
import 'package:tankwatcher/Classes/superheavy.dart';
import 'package:tankwatcher/Screens/AboutScreen.dart';
import 'package:tankwatcher/Screens/FleetListScreen.dart';
import 'package:tankwatcher/Screens/NewsScreen.dart';
import '../design.dart';

class ScrollWidget extends StatefulWidget {
  ScrollWidget(
      {Key? key,
      required this.closureData,
      required this.starshipData,
      required this.superHeavyData,
      required this.eventData,
      required this.activityLogData})
      : super(key: key);

  String closureData;
  List<Starship> starshipData;
  List<Superheavy> superHeavyData;
  List<ActivityLog> activityLogData;
  List<Events> eventData;

  @override
  _ScrollWidget createState() => _ScrollWidget();
}

class _ScrollWidget extends State<ScrollWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(
                    top: kDefaultPadding * 2, bottom: kDefaultPadding / 2),
                child: Container(
                  width: 200.0,
                  height: 3.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).focusColor,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MenuButton(
                        title: "NEWS",
                        page: NewsScreen(
                          activityLogs: widget.activityLogData,
                          closures: widget.closureData,
                          events: widget.eventData,
                        )),
                    const SizedBox(width: kDefaultPadding * 2.5),
                    MenuButton(
                        title: "ABOUT",
                        page: AboutScreen(
                          lastDataUpdateDate: widget.activityLogData[0].date,
                        )),
                  ],
                ),
                MenuButton(
                    title: "STARSHIPS",
                    page: FleetListScreen(
                      starships: widget.starshipData,
                      superheavys: widget.superHeavyData,
                      isStarshipList: true,
                    )),
                MenuButton(
                  title: "SUPERHEAVYS",
                  page: FleetListScreen(
                    starships: widget.starshipData,
                    superheavys: widget.superHeavyData,
                    isStarshipList: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  MenuButton({Key? key, required this.title, required this.page})
      : super(key: key);

  String title;
  Widget page;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 50.0,
          child: Center(
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: kScndTitleSize,
                fontWeight: FontWeight.w100,
                color: Theme.of(context).focusColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
