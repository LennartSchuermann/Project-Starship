// ignore_for_file: file_names, prefer_const_constructors_in_immutables, non_constant_identifier_names, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tankwatcher/Classes/log.dart';
import 'package:tankwatcher/design.dart';

class Roadmap extends StatelessWidget {
  Roadmap({
    Key? key,
    required this.activityLogs,
  }) : super(key: key);
  List<ActivityLog> activityLogs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: kDefaultPadding * 3,
                left: kDefaultPadding,
                right: kDefaultPadding),
            child: Column(
              children: [
                //TITLE
                Row(
                  children: [
                    Text(
                      "ROADMAP",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: kPageTitleSize,
                        fontWeight: FontWeight.w200,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding),
                //EVENTS
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * (1 / 3) -
                              kDefaultPadding * 2,
                          height: kDefaultPadding * 2,
                        ),
                        Container(
                          width: 2,
                          height: activityLogs.length * 90,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).focusColor,
                                Theme.of(context).focusColor.withOpacity(0),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              tileMode: TileMode.clamp,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * (2 / 3) -
                              kDefaultPadding * 1.5,
                          height: kDefaultPadding * 2,
                        )
                      ],
                    ),
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: kDefaultPadding / 4),
                      itemCount: activityLogs.length,
                      itemBuilder: (context, i) {
                        return i > 0
                            ? ChangesCard(
                                date: activityLogs[i].date,
                                change: activityLogs[i].changes[0],
                              )
                            : const SizedBox();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChangesCard extends StatelessWidget {
  ChangesCard({Key? key, required this.change, required this.date})
      : super(key: key);
  String date, change;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //DATES
          SizedBox(
            width: MediaQuery.of(context).size.width * (1 / 3) -
                kDefaultPadding * 2,
            height: kDefaultPadding * 2.5,
            child: Text(
              date,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: kDesFontSize + 4,
                fontWeight: FontWeight.w100,
                color: Theme.of(context).focusColor.withOpacity(0.8),
              ),
            ),
          ),
          //CIRCLE
          Padding(
            padding: const EdgeInsets.only(bottom: 26.0),
            child: Container(
              width: kDefaultPadding / 2,
              height: kDefaultPadding / 2,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).backgroundColor,
                    width: 1,
                  ),
                  color: Theme.of(context).focusColor,
                  shape: BoxShape.circle),
            ),
          ),
          //CHANGES
          SizedBox(
            width: MediaQuery.of(context).size.width * (2 / 3) -
                kDefaultPadding * 1.5,
            height: kDefaultPadding * 2.5,
            child: Text(
              change,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: kDesFontSize + 4,
                fontWeight: FontWeight.w200,
                color: Theme.of(context).focusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
