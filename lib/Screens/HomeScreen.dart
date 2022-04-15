// ignore_for_file: file_names, prefer_const_constructors_in_immutables, non_constant_identifier_names, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tankwatcher/Classes/fetchservice.dart';
import 'package:tankwatcher/Screens/InfoScreen.dart';
import 'package:tankwatcher/Utils/dateHandling.dart';
import 'package:tankwatcher/Utils/parts.dart';
import 'package:tankwatcher/Utils/scraper.dart';
import 'package:tankwatcher/Widgets/scrollWidget.dart';
import 'package:tankwatcher/Widgets/StarshipCard.dart';
import 'package:tankwatcher/Widgets/SuperheavyCard.dart';

import '../design.dart';

var starship_service = StarshipService();

class HomeScreen extends StatefulWidget {
  HomeScreen(
      {Key? key,
      this.closureData,
      this.starshipData,
      this.superHeavyData,
      this.eventsData,
      this.activityLogData})
      : super(key: key);

  String? closureData;
  List? starshipData;
  List? superHeavyData;
  List? activityLogData;
  List? eventsData;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Theme.of(context).backgroundColor,
          statusBarIconBrightness: Theme.of(context).brightness,
          systemNavigationBarIconBrightness: Theme.of(context).brightness,
        ),
        child: Scaffold(
          body: SlidingUpPanel(
              panelBuilder: (scrollController) => buildSlidingPanel(
                    scrollController: scrollController,
                  ),
              maxHeight: 300,
              minHeight: 70,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              border: Border.all(
                color: Theme.of(context).backgroundColor,
                width: 0.0,
              ),
              backdropColor: Theme.of(context).backgroundColor,
              parallaxEnabled: true,
              body: ListView(
                padding: const EdgeInsets.all(0),
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: kDefaultPadding * 3,
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                        bottom: kDefaultPadding * 5),
                    child: Column(
                      children: [
                        //TITLE
                        Row(
                          children: [
                            Text(
                              kAppName,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: kPageTitleSize,
                                fontWeight: FontWeight.w100,
                                color: Theme.of(context).focusColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: kDefaultPadding),
                        //NRC Feed
                        RoadClosureFeed(
                          data: widget.closureData,
                        ),
                        //Next Road Closure
                        const SizedBox(height: kDefaultPadding),
                        //STATS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Fleet:",
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
                        GestureDetector(
                          child: FadeTransition(
                            opacity: _animation,
                            child: StarshipCard(
                              starship: getStarshipFleet(
                                  starship_service.getStarshipData(
                                      widget.starshipData,
                                      widget.starshipData!.length)),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InfoScreen(
                                  isStarshipInfo: true,
                                  starship: getStarshipFleet(
                                      starship_service.getStarshipData(
                                          widget.starshipData,
                                          widget.starshipData!.length)),
                                  superheavy: getSuperHeavyFleet(
                                      starship_service.getSuperheavyData(
                                          widget.superHeavyData,
                                          widget.superHeavyData!.length)),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: kDefaultPadding),
                        GestureDetector(
                          child: FadeTransition(
                            opacity: _animation,
                            child: SuperHeavyCard(
                              superheavy: getSuperHeavyFleet(
                                  starship_service.getSuperheavyData(
                                      widget.superHeavyData,
                                      widget.superHeavyData!.length)),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InfoScreen(
                                  isStarshipInfo: false,
                                  superheavy: getSuperHeavyFleet(
                                      starship_service.getSuperheavyData(
                                          widget.superHeavyData,
                                          widget.superHeavyData!.length)),
                                  starship: getStarshipFleet(
                                      starship_service.getStarshipData(
                                          widget.starshipData,
                                          widget.starshipData!.length)),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }

  Widget buildSlidingPanel({
    required ScrollController scrollController,
  }) =>
      ScrollWidget(
        activityLogData: starship_service.getActivityLogData(
            widget.activityLogData, widget.activityLogData!.length),
        closureData: widget.closureData!,
        starshipData: starship_service.getStarshipData(
            widget.starshipData, widget.starshipData!.length),
        superHeavyData: starship_service.getSuperheavyData(
            widget.superHeavyData, widget.superHeavyData!.length),
        eventData: starship_service.getEventsData(
            widget.eventsData, widget.eventsData!.length),
      );
}

class RoadClosureFeed extends StatelessWidget {
  RoadClosureFeed({
    Key? key,
    this.data,
  }) : super(key: key);

  String? data;

  @override
  Widget build(BuildContext context) {
    int activeClosure = getNextActiveClosure(data!);
    String date = activeClosure != -1
        ? getClosureInf(data.toString(), 3)[activeClosure].toString()
        : "0";

    return (activeClosure != -1
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Next Road Closure:",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: kScndTitleSize,
                      fontWeight: FontWeight.w100,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: kDefaultPadding,
                    height: kDefaultPadding * 2,
                  ),
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
                  Text(
                    date,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: kFontSize,
                      fontWeight: FontWeight.w100,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ],
              )
            ],
          )
        : const SizedBox());
  }
}
