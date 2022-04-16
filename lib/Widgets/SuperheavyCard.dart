// ignore_for_file: file_names, prefer_const_constructors_in_immutables, non_constant_identifier_names, must_be_immutable, avoid_multiple_declarations_per_line

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:tankwatcher/Classes/superheavy.dart';
import 'package:tankwatcher/Utils/parts.dart';
import 'package:tankwatcher/Widgets/IconStats.dart';
import 'package:tankwatcher/Widgets/StarshipCard.dart';
import 'package:tankwatcher/design.dart';

class SuperHeavyCard extends StatelessWidget {
  SuperHeavyCard({
    Key? key,
    required this.superheavy,
  }) : super(key: key);

  Superheavy superheavy;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      width: MediaQuery.of(context).size.width - (2 * kDefaultPadding),
      height: 220,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //IMG DIAGRAM
          SizedBox(
            width:
                (MediaQuery.of(context).size.width - (2 * kDefaultPadding)) / 3,
            child: SuperHeavyPartsDiagram(superheavy: superheavy),
          ),
          //STATS CONTAINER
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
                      superheavy.serialnumber,
                      style: TextStyle(
                        color: Theme.of(context).focusColor,
                        fontFamily: 'Roboto',
                        fontSize: kScndTitleSize,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    //LOCATION
                    Text(
                      superheavy.location,
                      style: TextStyle(
                        color: Theme.of(context).focusColor.withOpacity(0.6),
                        fontFamily: 'Roboto',
                        fontSize: kDesFontSize,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
                //STATS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //DIAGRAM
                    SuperheavyEngineDiagram(
                      superheavy: superheavy,
                      height: 94,
                      width: 94,
                    ),
                    IconStats(
                      img_source: "",
                      amount: superheavy.cryoproof,
                      icon: CupertinoIcons.snow,
                    ),
                    IconStats(
                      img_source: "",
                      amount: superheavy.staticfire,
                      icon: CupertinoIcons.flame,
                    ),
                    IconStats(
                      img_source: "icons/flight_icon",
                      amount: superheavy.flights,
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

class SuperheavyEngineDiagram extends StatelessWidget {
  const SuperheavyEngineDiagram({
    Key? key,
    required this.superheavy,
    this.height,
    this.width,
  }) : super(key: key);

  final Superheavy superheavy;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          superheavy.raptorCount == 29
              ? SuperheavyEngineStack(
                  isOldDesgin: true,
                  isBodyReady: superheavy.parts[0],
                  width: width,
                  height: height,
                  seaRaptorBooleans: superheavy.sea,
                )
              : SuperheavyEngineStack(
                  isOldDesgin: false,
                  isBodyReady: superheavy.parts[0],
                  width: width,
                  height: height,
                  seaRaptorBooleans: superheavy.sea,
                ),
        ],
      ),
    );
  }
}

class SuperheavyEngineStack extends StatelessWidget {
  const SuperheavyEngineStack({
    Key? key,
    required this.width,
    required this.height,
    required this.seaRaptorBooleans,
    required this.isOldDesgin,
    required this.isBodyReady,
  }) : super(key: key);

  final double? width;
  final double? height;

  final List seaRaptorBooleans;
  final bool isOldDesgin, isBodyReady;

  @override
  Widget build(BuildContext context) {
    //Out, Middle, Inner
    final List<int> oldSeaRCount = [0, 1, 2];
    return isOldDesgin
        ? Stack(
            //OLD
            children: [
              //TRANSPARENT
              SvgPicture.asset(
                engine_layout_old_sh,
                color: Theme.of(context).focusColor.withOpacity(0.2),
                width: width,
                height: height,
              ),
              isBodyReady
                  ? SvgPicture.asset(
                      shRings,
                      color: Theme.of(context).focusColor,
                      width: width,
                      height: height,
                    )
                  : const SizedBox(),
              //SEA-RAPTORS (29)
              for (var i in oldSeaRCount)
                Raptor(
                  display: seaRaptorBooleans[i],
                  path: shEnginepath + "sea_" + (i).toString() + ".svg",
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
                engine_layout_new_sh,
                color: Theme.of(context).focusColor.withOpacity(0.2),
                width: width,
                height: height,
              ),
              isBodyReady
                  ? SvgPicture.asset(
                      shRings,
                      color: Theme.of(context).focusColor,
                      width: width,
                      height: height,
                    )
                  : const SizedBox(),
              //SEA-RAPTORS (33)
              for (var i in oldSeaRCount)
                Raptor(
                  display: seaRaptorBooleans[i],
                  path: shEnginepath + "new_sea_" + (i).toString() + ".svg",
                  width: width,
                  height: height,
                ),
            ],
          );
  }
}

class SuperHeavyPartsDiagram extends StatelessWidget {
  const SuperHeavyPartsDiagram(
      {Key? key, required this.superheavy, this.width, this.height})
      : super(key: key);

  final Superheavy superheavy;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return superheavy.status != "Test Tank"
        ? Stack(
            children: [
              //Transparent
              SvgPicture.asset(
                'assets/images/superheavy.svg',
                color: Theme.of(context).focusColor.withOpacity(0.2),
                width: width,
                height: height,
              ),
              //PARTS
              Parts(
                img: 'assets/images/superheavy_gridfins.svg',
                show: superheavy.parts[2],
                width: width,
                height: height,
              ),
              Parts(
                img: 'assets/images/superheavy_flighthardware.svg',
                show: superheavy.parts[1],
                width: width,
                height: height,
              ),
              Parts(
                img: 'assets/images/super_heavy_tank.svg',
                show: superheavy.parts[0],
                width: width,
                height: height,
              ),
            ],
          )
        : Stack(
            children: [
              SvgPicture.asset(
                'assets/images/test_tank.svg',
                color: Theme.of(context).focusColor,
              ),
            ],
          );
  }
}
