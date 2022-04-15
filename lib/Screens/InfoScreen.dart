// ignore_for_file: file_names, prefer_const_constructors_in_immutables, non_constant_identifier_names, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:tankwatcher/Classes/starship.dart';
import 'package:tankwatcher/Classes/superheavy.dart';
import 'package:tankwatcher/Screens/AboutScreen.dart';
import 'package:tankwatcher/Widgets/IconStats.dart';
import 'package:tankwatcher/Widgets/StarshipCard.dart';
import 'package:tankwatcher/Widgets/SuperheavyCard.dart';

import '../design.dart';

class InfoScreen extends StatelessWidget {
  InfoScreen(
      {Key? key, this.starship, this.superheavy, required this.isStarshipInfo})
      : super(key: key);
  bool isStarshipInfo;
  Starship? starship;
  Superheavy? superheavy;

  @override
  Widget build(BuildContext context) {
    String imgLink() {
      if (isStarshipInfo && starship!.imglink != "") {
        return starship!.imglink;
      } else if (!isStarshipInfo && superheavy!.imglink != "") {
        return superheavy!.imglink;
      } else {
        return "";
      }
    }

    IconData getStatus() {
      String status = "";
      if (isStarshipInfo) {
        status = starship!.status;
      } else if (!isStarshipInfo) {
        status = superheavy!.status;
      }

      //TODO ADD REAL ICONS
      if (status == "Scrapped") {
        return CupertinoIcons.trash;
      } else if (status == "Testing") {
        return CupertinoIcons.lab_flask;
      } else if (status == "Parking") {
        return CupertinoIcons.zzz;
      } else if (status == "Under Construction") {
        return CupertinoIcons.paintbrush;
      } else if (status == "Stacked" || status == "In Orbit") {
        return CupertinoIcons.rocket_fill;
      } else if (status == "RUD") {
        return CupertinoIcons.burst;
      } else if (status == "Turn Around") {
        return CupertinoIcons.arrow_2_circlepath;
      } else {
        return CupertinoIcons.question;
      }
    }

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          isStarshipInfo
                              ? starship!.serialnumber
                              : superheavy!.serialnumber,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: kPageTitleSize,
                            fontWeight: FontWeight.w100,
                            color: Theme.of(context).focusColor,
                          ),
                        ),
                        const SizedBox(width: kDefaultPadding / 2),
                        Text(
                          isStarshipInfo
                              ? starship!.location
                              : superheavy!.location,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: kFontSize,
                            fontWeight: FontWeight.w100,
                            color:
                                Theme.of(context).focusColor.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    //STATUS ICON
                    Icon(
                      getStatus(),
                      color: Theme.of(context).focusColor,
                      size: 28,
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding),
                //IMG
                Container(
                  width:
                      MediaQuery.of(context).size.width - (kDefaultPadding / 2),
                  height: 250,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).focusColor,
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(kDefaultPadding)),
                  child: imgLink() != ""
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(
                              kDefaultPadding - kDefaultPadding * 0.1),
                          child: Stack(
                            children: [
                              FadeInImage.assetNetwork(
                                fadeInDuration:
                                    const Duration(milliseconds: 200),
                                placeholder: "assets/images/placeholder.png",
                                image: imgLink(),
                                height: 250,
                                width: MediaQuery.of(context).size.width -
                                    (kDefaultPadding / 2),
                                fit: BoxFit.cover,
                              ),
                              //IMG SOURCE
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: kDefaultPadding / 2),
                                  child: Text(
                                    isStarshipInfo
                                        ? starship!.imgsource
                                        : superheavy!.imgsource,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: kDesFontSize,
                                      fontWeight: FontWeight.w100,
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ))
                      : Center(
                          child: Text(
                            "No Image yet!",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: kFontSize,
                              fontWeight: FontWeight.w100,
                              color: Theme.of(context).focusColor,
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: kDefaultPadding),
                //UPDATE STATS
                Padding(
                  padding: const EdgeInsets.only(
                      left: kDefaultPadding, right: kDefaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //ICON STATS
                      IconStats(
                        img_source: "",
                        amount: isStarshipInfo
                            ? starship!.cryoproof
                            : superheavy!.cryoproof,
                        icon: CupertinoIcons.snow,
                      ),
                      IconStats(
                        img_source: "",
                        amount: isStarshipInfo
                            ? starship!.staticfire
                            : superheavy!.staticfire,
                        icon: CupertinoIcons.flame,
                      ),
                      IconStats(
                        img_source: "icons/flight_icon",
                        amount: isStarshipInfo
                            ? starship!.flights
                            : superheavy!.flights,
                        icon: CupertinoIcons.rocket,
                      ),
                      IconStats(
                        img_source: "icons/landing_icon",
                        amount: isStarshipInfo
                            ? starship!.landings
                            : superheavy!.landings,
                        icon: CupertinoIcons.rocket,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                //INFOS & DIAGRAMS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //DIAGRAM
                    SizedBox(
                      child: isStarshipInfo
                          ? StarshipPartsDiagram(
                              starship: starship!,
                              width: 115,
                              height: 312,
                            )
                          : SuperHeavyPartsDiagram(
                              superheavy: superheavy!,
                              width: 115,
                              height: 312,
                            ),
                    ),
                    //Infos / Engine
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - (115 + 50),
                          height: 312 / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isStarshipInfo
                                    ? "Status: " + starship!.status
                                    : "Status: " + superheavy!.status,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: kFontSize,
                                  fontWeight: FontWeight.w100,
                                  color: Theme.of(context).focusColor,
                                ),
                              ),
                              Text(
                                isStarshipInfo
                                    ? starship!.boosternr == 0
                                        ? "Booster Pair: -"
                                        : "Booster Pair: B" +
                                            starship!.boosternr.toString()
                                    : superheavy!.starshipnr == 0
                                        ? "Starship Pair: -"
                                        : "Starship Pair: S" +
                                            superheavy!.starshipnr.toString(),
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: kFontSize,
                                  fontWeight: FontWeight.w100,
                                  color: Theme.of(context).focusColor,
                                ),
                              ),
                              Text(
                                isStarshipInfo
                                    ? "Purpose: " + starship!.purpose.toString()
                                    : "Purpose: " +
                                        superheavy!.purpose.toString(),
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: kFontSize,
                                  fontWeight: FontWeight.w100,
                                  color: Theme.of(context).focusColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - (115 + 50),
                          height: 312 / 2,
                          child: isStarshipInfo
                              ? Center(
                                  child: StarshipEngineDiagram(
                                    starship: starship!,
                                    height: 312 / 2,
                                    width: 312 / 2,
                                  ),
                                )
                              : Center(
                                  child: SuperheavyEngineDiagram(
                                    superheavy: superheavy!,
                                    height: 312 / 2,
                                    width: 312 / 2,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding * 1.5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
