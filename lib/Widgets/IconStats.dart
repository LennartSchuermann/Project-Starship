// ignore_for_file: file_names, prefer_const_constructors_in_immutables, non_constant_identifier_names, must_be_immutable

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import '../design.dart';

class IconStats extends StatelessWidget {
  IconStats({
    Key? key,
    required this.amount,
    required this.icon,
    required this.img_source,
  }) : super(key: key);

  int amount;
  IconData icon;
  String img_source;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //ICON STATS
        img_source == ""
            ? Icon(
                icon,
                color: Theme.of(context).focusColor,
                size: 28,
              )
            : SizedBox(
                width: 28,
                height: 28,
                child: SvgPicture.asset(
                  'assets/images/' + img_source + '.svg',
                  color: Theme.of(context).focusColor,
                ),
              ),
        Text(
          amount.toString() + "x",
          style: TextStyle(
            color: Theme.of(context).focusColor,
            fontFamily: 'Roboto',
            fontSize: kScndTitleSize,
            fontWeight: FontWeight.w100,
          ),
        ),
      ],
    );
  }
}
