// ignore_for_file: file_names, prefer_const_constructors_in_immutables, non_constant_identifier_names, must_be_immutable

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// Project imports:
import 'package:tankwatcher/Classes/events.dart';
import 'package:tankwatcher/Classes/log.dart';
import 'package:tankwatcher/Screens/AboutScreen.dart';
import 'package:tankwatcher/Screens/EventsScreen.dart';
import 'package:tankwatcher/Utils/dateHandling.dart';
import 'package:tankwatcher/Utils/scraper.dart';
import '../design.dart';
import 'RoadmapScreen.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen(
      {Key? key,
      required this.activityLogs,
      required this.closures,
      required this.events})
      : super(key: key);
  List<ActivityLog> activityLogs;
  List<Events> events;
  String closures;

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
                      "NEWS",
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
                //LIVE FEED
                BrowserLink(
                  url: "https://youtu.be/mhJRzQsLZGg",
                  title: "NSF Live Feed",
                ),
                const SizedBox(height: kDefaultPadding / 2),
                //CLOSURES
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Road Closures:",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: kScndTitleSize,
                        fontWeight: FontWeight.w100,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: kDefaultPadding / 4),
                  itemCount: getClosureAmount(closures),
                  itemBuilder: (context, i) {
                    return Padding(
                        padding:
                            const EdgeInsets.only(bottom: kDefaultPadding / 10),
                        child: ClosureCard(
                          title: getClosureInf(closures, 2)[i].toString() + ":",
                          date: getClosureInf(closures, 3)[i].toString(),
                          time: getClosureInf(closures, 4)[i].toString(),
                          desc: getClosureInf(closures, 5)[i].toString(),
                        ));
                  },
                ),
                const SizedBox(height: kDefaultPadding),
                //ROADMAP BTN
                RoundBtn(
                  title: "Roadmap",
                  goTo: Roadmap(
                    activityLogs: activityLogs,
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                //EVENT BTN
                RoundBtn(
                  title: "Events",
                  goTo: EventsScreen(
                    events: events,
                  ),
                ),

                //UPDATE LOG
                /* Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Updates:",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: kScndTitleSize,
                        fontWeight: FontWeight.w100,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  itemCount: activityLogs.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(bottom: kDefaultPadding / 15),
                      child: ListTile(
                          title: Text(
                            "[" + activityLogs[i].date + "]",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: kFontSize,
                              fontWeight: FontWeight.w100,
                              color: Theme.of(context).focusColor,
                            ),
                          ),
                          subtitle: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: activityLogs[i].changes.length,
                            itemBuilder: (context, j) {
                              return Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).focusColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: kDefaultPadding / 2,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width -
                                        (kDefaultPadding * 4.5),
                                    child: Text(
                                      activityLogs[i].changes[j],
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: kFontSize,
                                        fontWeight: FontWeight.w100,
                                        color: Theme.of(context).focusColor,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          )),
                    );
                  },
                )
               */
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClosureCard extends StatelessWidget {
  ClosureCard({
    required this.date,
    required this.time,
    required this.desc,
    required this.title,
    Key? key,
  }) : super(key: key);

  String title, date, time, desc;

  @override
  Widget build(BuildContext context) {
    return !isClosureGone(date, time)
        ? Padding(
            padding: const EdgeInsets.only(bottom: kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        decoration: isCancled(desc)
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationThickness: 1.5,
                        color: Theme.of(context).focusColor,
                        fontFamily: 'Roboto',
                        fontSize: kFontSize,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    isClosureLive(desc, date, time)
                        ? Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                Text(
                  time + '\n (' + desc + ")",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Theme.of(context).focusColor,
                    fontFamily: 'Roboto',
                    fontSize: kFontSize,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
