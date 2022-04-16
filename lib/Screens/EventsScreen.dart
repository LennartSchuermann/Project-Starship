// ignore_for_file: file_names, prefer_const_constructors_in_immutables, non_constant_identifier_names, must_be_immutable

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:tankwatcher/Classes/events.dart';
import 'package:tankwatcher/design.dart';

class EventsScreen extends StatelessWidget {
  EventsScreen({Key? key, required this.events}) : super(key: key);

  List<Events> events;

  List<Events> doneEvents() {
    List<Events> done = [];
    for (Events event in events) {
      if (event.isDone) {
        done.add(event);
      }
    }
    return done;
  }

  List<Events> notDoneEvents() {
    List<Events> notdone = [];
    for (Events event in events) {
      if (!event.isDone) {
        notdone.add(event);
      }
    }
    return notdone;
  }

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
              right: kDefaultPadding,
            ),
            child: Column(
              children: [
                //TITLE
                Row(
                  children: [
                    Text(
                      "EVENTS",
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

                //UPCOMING
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Upcoming:",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: kScndTitleSize,
                        fontWeight: FontWeight.w100,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding),
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: kDefaultPadding / 4),
                  itemCount: notDoneEvents().length,
                  itemBuilder: (context, i) {
                    return EventCard(
                      event: notDoneEvents()[i],
                      index: i,
                    );
                  },
                ),
                const SizedBox(height: kDefaultPadding),

                //DONE
                doneEvents().isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Done:",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: kScndTitleSize,
                              fontWeight: FontWeight.w100,
                              color: Theme.of(context).focusColor,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(height: kDefaultPadding),
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: kDefaultPadding / 4),
                  itemCount: doneEvents().length,
                  itemBuilder: (context, i) {
                    return EventCard(
                      event: doneEvents()[i],
                      index: i,
                    );
                  },
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

class EventCard extends StatelessWidget {
  EventCard({Key? key, required this.event, required this.index})
      : super(key: key);

  Events event;
  int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      child: Container(
        width: MediaQuery.of(context).size.width - (2 * kDefaultPadding),
        height: kDefaultPadding * 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultPadding),
          border: Border.all(
            width: 1.5,
            color: index == 0
                ? Theme.of(context).focusColor
                : Theme.of(context).backgroundColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                event.title,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: kScndTitleSize,
                  fontWeight: FontWeight.w200,
                  color: Theme.of(context).focusColor,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    event.date,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: kDesFontSize,
                      fontWeight: FontWeight.w200,
                      color: Theme.of(context).focusColor.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    event.location,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: kDesFontSize,
                      fontWeight: FontWeight.w200,
                      color: Theme.of(context).focusColor.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
