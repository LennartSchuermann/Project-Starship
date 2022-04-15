// ignore_for_file: file_names, prefer_const_constructors_in_immutables, non_constant_identifier_names, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:tankwatcher/Classes/starship.dart';
import 'package:tankwatcher/Classes/superheavy.dart';
import 'package:tankwatcher/Screens/InfoScreen.dart';
import 'package:tankwatcher/Widgets/StarshipCard.dart';
import 'package:tankwatcher/Widgets/SuperheavyCard.dart';

import '../design.dart';

class FleetListScreen extends StatefulWidget {
  FleetListScreen(
      {Key? key,
      required this.starships,
      required this.superheavys,
      required this.isStarshipList})
      : super(key: key);
  bool isStarshipList;
  List<Starship> starships;
  List<Superheavy> superheavys;
  bool reverseList = false;

  @override
  _FleetListScreenState createState() => _FleetListScreenState();
}

class _FleetListScreenState extends State<FleetListScreen> {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.isStarshipList
                          ? "Starships".toUpperCase()
                          : "Superheavys".toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: kPageTitleSize,
                        fontWeight: FontWeight.w100,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                    //SORT BTN
                    GestureDetector(
                      onTap: () {
                        if (widget.reverseList) {
                          setState(() {
                            widget.reverseList = false;
                          });
                        } else {
                          setState(() {
                            widget.reverseList = true;
                          });
                        }
                      },
                      child: Icon(
                        widget.reverseList
                            ? CupertinoIcons.sort_up
                            : CupertinoIcons.sort_down,
                        color: Theme.of(context).focusColor,
                        size: 28,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                //CARDS
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: kDefaultPadding / 4),
                  reverse: widget.reverseList,
                  itemCount: widget.isStarshipList
                      ? widget.starships.length
                      : widget.superheavys.length,
                  itemBuilder: (context, i) {
                    return Padding(
                        padding: EdgeInsets.only(
                            bottom: widget.isStarshipList
                                ? kDefaultPadding / 6
                                : kDefaultPadding),
                        child: widget.isStarshipList
                            ? GestureDetector(
                                child: StarshipCard(
                                  starship: widget.starships[i],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InfoScreen(
                                        isStarshipInfo: true,
                                        starship: widget.starships[i],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : GestureDetector(
                                child: SuperHeavyCard(
                                  superheavy: widget.superheavys[i],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InfoScreen(
                                        isStarshipInfo: false,
                                        superheavy: widget.superheavys[i],
                                      ),
                                    ),
                                  );
                                },
                              ));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
