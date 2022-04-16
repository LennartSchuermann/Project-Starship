// ignore_for_file: file_names, prefer_const_constructors_in_immutables, non_constant_identifier_names, must_be_immutable, avoid_multiple_declarations_per_line

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:tankwatcher/Classes/starship.dart';
import 'package:tankwatcher/Utils/parts.dart';
import 'package:tankwatcher/Widgets/IconStats.dart';
import 'package:tankwatcher/design.dart';

class StarshipCard extends StatelessWidget {
  StarshipCard({Key? key, required this.starship}) : super(key: key);

  Starship starship;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      width: MediaQuery.of(context).size.width - (2 * kDefaultPadding),
      height: 190,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //IMG DIAGRAM
          SizedBox(
            width: (MediaQuery.of(context).size.width - (2 * kDefaultPadding)) /
                    3 -
                12,
            child: StarshipPartsDiagram(starship: starship),
          ),
          //STATS
          SizedBox(
            width: (MediaQuery.of(context).size.width - (2 * kDefaultPadding)) *
                (2 / 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //SERAIAL NUMBER
                    Text(
                      starship.serialnumber,
                      style: TextStyle(
                        color: Theme.of(context).focusColor,
                        fontFamily: 'Roboto',
                        fontSize: kScndTitleSize,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    //LOCATION
                    Text(
                      starship.location,
                      style: TextStyle(
                        color: Theme.of(context).focusColor.withOpacity(0.6),
                        fontFamily: 'Roboto',
                        fontSize: kDesFontSize,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
                //SHORT STATS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //DIAGRAM (engine_layout_dummy.svg)
                    StarshipEngineDiagram(starship: starship),
                    IconStats(
                      img_source: "",
                      amount: starship.cryoproof,
                      icon: CupertinoIcons.snow,
                    ),
                    IconStats(
                      img_source: "",
                      amount: starship.staticfire,
                      icon: CupertinoIcons.flame,
                    ),
                    IconStats(
                      img_source: "icons/flight_icon",
                      amount: starship.flights,
                      icon: CupertinoIcons.rocket,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StarshipEngineDiagram extends StatelessWidget {
  const StarshipEngineDiagram({
    Key? key,
    required this.starship,
    this.height,
    this.width,
  }) : super(key: key);

  final Starship starship;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: starship.sea.length + starship.vac.length < 9
          ? EngineStack(
              isOldDesgin: true,
              isBodyReady: starship.parts[1],
              width: width,
              height: height,
              seaRaptorBooleans: starship.sea,
              vacRaptorBooleans: starship.vac,
            )
          : EngineStack(
              isOldDesgin: false,
              isBodyReady: starship.parts[1],
              width: width,
              height: height,
              seaRaptorBooleans: starship.sea,
              vacRaptorBooleans: starship.vac,
            ),
    );
  }
}

class EngineStack extends StatelessWidget {
  const EngineStack({
    Key? key,
    required this.width,
    required this.height,
    required this.seaRaptorBooleans,
    required this.vacRaptorBooleans,
    required this.isOldDesgin,
    required this.isBodyReady,
  }) : super(key: key);

  final double? width;
  final double? height;

  final List seaRaptorBooleans;
  final List vacRaptorBooleans;
  final bool isOldDesgin, isBodyReady;

  @override
  Widget build(BuildContext context) {
    final List<int> oldRVacCount = [0, 1, 2];
    final List<int> newRVacCount = [0, 1, 2, 3, 4, 5];
    return isOldDesgin
        ? Stack(
            //OLD
            children: [
              //TRANSPARENT
              SvgPicture.asset(
                engine_layout_old,
                color: Theme.of(context).focusColor.withOpacity(0.2),
                width: width,
                height: height,
              ),
              if (isBodyReady)
                SvgPicture.asset(
                  rings,
                  color: Theme.of(context).focusColor,
                  width: width,
                  height: height,
                )
              else
                const SizedBox(),
              //SEA-RAPTORS
              for (var i in oldRVacCount)
                Raptor(
                  display: seaRaptorBooleans[i],
                  path: "${enginepath}sea_${i + 1}.svg",
                  width: width,
                  height: height,
                ),

              //VAC-RAPTORS
              for (var i in oldRVacCount)
                Raptor(
                  display: vacRaptorBooleans[i],
                  path: "${enginepath}vac_old_${i + 1}.svg",
                  width: width,
                  height: height,
                ),
            ],
          )
        : Stack(
            //NEW
            children: [
              //TRANSPARENT
              SvgPicture.asset(
                engine_layout_new,
                color: Theme.of(context).focusColor.withOpacity(0.2),
                width: width,
                height: height,
              ),
              //SEA-RAPTORS
              for (var i in oldRVacCount)
                Raptor(
                  display: seaRaptorBooleans[i],
                  path: "${enginepath}sea_${i + 1}.svg",
                  width: width,
                  height: height,
                ), //VAC-RAPTORS
              //VAC-RAPTORS
              for (var i in newRVacCount)
                Raptor(
                  display: vacRaptorBooleans[i],
                  path: "${enginepath}vac_new_${i + 1}.svg",
                  width: width,
                  height: height,
                ),
            ],
          );
  }
}

class Raptor extends StatelessWidget {
  const Raptor({
    Key? key,
    this.width,
    this.height,
    required this.display,
    required this.path,
  }) : super(key: key);
  final double? width;
  final double? height;

  final bool display;
  final String path;

  @override
  Widget build(BuildContext context) {
    return display
        ? SvgPicture.asset(
            path,
            color: Theme.of(context).focusColor,
            width: width,
            height: height,
          )
        : const SizedBox();
  }
}

class StarshipPartsDiagram extends StatelessWidget {
  const StarshipPartsDiagram({
    Key? key,
    required this.starship,
    this.width,
    this.height,
  }) : super(key: key);

  final Starship starship;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Transparent
        SvgPicture.asset(
          starship_bg,
          color: Theme.of(context).focusColor.withOpacity(0.2),
          width: width,
          height: height,
        ),
        //PARTS
        Parts(
          img: bottom_flaps,
          show: starship.parts[0],
          width: width,
          height: height,
        ),
        Parts(
          img: starship_body,
          show: starship.parts[1],
          width: width,
          height: height,
        ),
        Parts(
          img: nose_cone,
          show: starship.parts[2],
          width: width,
          height: height,
        ),
        Parts(
          img: top_flaps,
          show: starship.parts[3],
          width: width,
          height: height,
        ),
      ],
    );
  }
}

class Parts extends StatelessWidget {
  Parts({
    Key? key,
    required this.img,
    required this.show,
    this.width,
    this.height,
  }) : super(key: key);

  String img;
  bool show;
  double? width, height;

  @override
  Widget build(BuildContext context) {
    return show
        ? SvgPicture.asset(
            img,
            color: Theme.of(context).focusColor,
            width: width,
            height: height,
          )
        : const SizedBox();
  }
}
