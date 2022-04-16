// ignore_for_file: file_names, prefer_const_constructors_in_immutables, non_constant_identifier_names, must_be_immutable

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/svg.dart';

// Project imports:
import 'package:tankwatcher/Screens/ContactScreen.dart';
import 'package:tankwatcher/Utils/openUrl.dart';
import 'package:tankwatcher/constants.dart';
import '../design.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({Key? key, required this.lastDataUpdateDate}) : super(key: key);

  String lastDataUpdateDate;

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
              bottom: kDefaultPadding,
              left: kDefaultPadding,
              right: kDefaultPadding,
            ),
            child: Column(
              children: [
                //TITLE
                Row(
                  children: [
                    Text(
                      "ABOUT",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: kPageTitleSize,
                        fontWeight: FontWeight.w100,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                //TOP INFOS
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "App-Version: v$kAppVersion",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: kFontSize,
                          fontWeight: FontWeight.w100,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                      Text(
                        "Last Data Update: $lastDataUpdateDate",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: kFontSize,
                          fontWeight: FontWeight.w100,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                      Text(
                        "Creator: Lennart S.",
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
                const SizedBox(height: kDefaultPadding),
                //ABOUT THE APP
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "About $kAppName:",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: kScndTitleSize,
                        fontWeight: FontWeight.w100,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding / 2),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "The purpose of this app is to easily get to know the status of SpaceX's Starship project at Boca Chica and the Cape. Keep in mind that there is information without official confirmation or missing data in general.\nI'm updating the data on my own asap (nearly every day), so I'm thankful for every kind of support.  I would also love it if you could rate this app and write some constructive criticism. I'd love to make this app better.\nGreetings, Lennart.",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: kFontSize,
                      fontWeight: FontWeight.w100,
                      color: Theme.of(context).focusColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                //LINKS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "More Apps: (by me)",
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
                BrowserLink(
                  url:
                      "https://play.google.com/store/apps/details?id=io.nucleon.launch",
                  title: "LAUNCH",
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                //SUPPORT
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Support:",
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
                BrowserLink(
                  url:
                      "https://www.paypal.com/donate/?hosted_button_id=MY2UTDA8FN3M4",
                  title: "Donate (PayPal)",
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          (2 * kDefaultPadding),
                      child: Text(
                        "All my apps are free and contain no advertising. I am therefore happy about any form of support. :)",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Theme.of(context).focusColor,
                          fontFamily: 'Roboto',
                          fontSize: kDesFontSize,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding),
                //ICONS Legend
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Icons:",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: kScndTitleSize,
                        fontWeight: FontWeight.w100,
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Description
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var des in descriptions)
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: kDefaultPadding / 2.5,
                            ),
                            child: Text(
                              des,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: kFontSize,
                                fontWeight: FontWeight.w100,
                                color: Theme.of(context).focusColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                    //Icons
                    Column(
                      children: [
                        for (var icon in icons)
                          icon is String
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: kDefaultPadding / 2.5,
                                  ),
                                  child: SizedBox(
                                    width: 21,
                                    height: 21,
                                    child: SvgPicture.asset(
                                      'assets/images/$icon.svg',
                                      color: Theme.of(context).focusColor,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: kDefaultPadding / 2.5,
                                  ),
                                  child: Icon(
                                    icon,
                                    color: Theme.of(context).focusColor,
                                    size: 21,
                                  ),
                                ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding * 2),
                //DISCLAIMER
                Row(
                  children: [
                    Text(
                      "Disclaimer:",
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
                const SizedBox(height: kDefaultPadding / 4),
                Text(
                  "I am not affiliated, associated, authorized, endorsed by, or in any way officially connected with Space Exploration Technologies Inc (SpaceX), or any of its subsidiaries or its affiliates. The names SpaceX as well as related names, marks, emblems, and images are registered trademarks of their respective owners." +
                      "\nAll images go under the CCO license, if you are the respective owner of one of the images please consider contacting me via: nucleoninteractive@gmail.com or the 'contact' button.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Theme.of(context).focusColor,
                    fontFamily: 'Roboto',
                    fontSize: kDesFontSize,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                const SizedBox(height: kDefaultPadding * 2),
                //CONTACT
                RoundBtn(
                  goTo: const ContactWidget(),
                  title: "Contact",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RoundBtn extends StatelessWidget {
  RoundBtn({
    required this.goTo,
    required this.title,
    Key? key,
  }) : super(key: key);

  Widget goTo;
  String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => goTo),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: kDefaultPadding),
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          height: kDefaultPadding * 3,
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(kDefaultPadding)),
            border: Border.all(width: 1.5, color: Theme.of(context).focusColor),
          ),
          child: Center(
            child: Text(
              title,
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

class BrowserLink extends StatelessWidget {
  BrowserLink({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  String url, title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openUrl(url);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: kDefaultPadding),
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          height: kDefaultPadding * 3,
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(kDefaultPadding)),
            border: Border.all(width: 1.5, color: Theme.of(context).focusColor),
          ),
          child: Center(
            child: Text(
              title,
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
