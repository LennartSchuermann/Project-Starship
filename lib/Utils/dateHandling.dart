// ignore_for_file: file_names, prefer_const_constructors_in_immutables, non_constant_identifier_names, must_be_immutable

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:tankwatcher/Utils/scraper.dart';

String getDayOfMonthSuffix(int dayNum) {
  if (!(dayNum >= 1 && dayNum <= 31)) {
    throw Exception('Invalid day of month');
  }

  if (dayNum >= 11 && dayNum <= 13) {
    return 'th';
  }

  switch (dayNum % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}

String getBCTime() {
  final now = DateTime.now().toUtc();

  var offsetDuration = const Duration();
  //BRUH THIS IS BULLSHIT
  if (now.day == 7 && now.month == 11 && now.hour == 2) {
    offsetDuration = const Duration(hours: -6);
  } else {
    offsetDuration = const Duration(hours: -5);
  }

  final DateTime newTime = now.add(offsetDuration);
  final dt =
      DateFormat("yyyy-MM-dd HH:mm:ss").parse(newTime.toString()).toLocal();
  return "${DateFormat('d').format(dt)}${getDayOfMonthSuffix(int.parse(DateFormat('d').format(dt)))} ${DateFormat('MMM yyyy').format(dt)} | ${DateFormat('HH:mm').format(dt)}";
}

String getMonthNr(String month) {
  if (month.contains("January")) {
    return "01";
  } else if (month.contains("February")) {
    return "02";
  } else if (month.contains("March")) {
    return "03";
  } else if (month.contains("April")) {
    return "04";
  } else if (month.contains("May")) {
    return "05";
  } else if (month.contains("June")) {
    return "06";
  } else if (month.contains("July")) {
    return "07";
  } else if (month.contains("August")) {
    return "08";
  } else if (month.contains("September")) {
    return "09";
  } else if (month.contains("October")) {
    return "10";
  } else if (month.contains("November")) {
    return "11";
  } else if (month.contains("December")) {
    return "12";
  } else {
    return "0";
  }
}

IconData getWeatherIcon(String? weatherDes) {
  if (weatherDes == "clear sky") {
    return CupertinoIcons.sun_max_fill;
  } else if (weatherDes == "few clouds") {
    return CupertinoIcons.cloud_sun;
  } else if (weatherDes == "scattered clouds") {
    return CupertinoIcons.cloud;
  } else if (weatherDes == "broken clouds" || weatherDes == "overcast clouds") {
    return CupertinoIcons.cloud_fill;
  } else if (weatherDes!.contains("drizzle")) {
    return CupertinoIcons.cloud_drizzle;
  } else if (weatherDes.contains("rain") &&
      !weatherDes.contains("thunderstorm")) {
    return CupertinoIcons.cloud_heavyrain;
  } else if (weatherDes == "thunderstorm" ||
      weatherDes.contains("thunderstorm")) {
    return CupertinoIcons.cloud_bolt_rain_fill;
  } else if (weatherDes == "snow" || weatherDes.contains("snow")) {
    return CupertinoIcons.cloud_snow;
  } else if (weatherDes == "mist" ||
      weatherDes == "haze" ||
      weatherDes == "fog") {
    return CupertinoIcons.cloud_fog;
  } else {
    return CupertinoIcons.question;
  }
}

bool isClosureLive(String des, String cl_date, String cl_time) {
  if (des == "Closure Scheduled" && getMonthNr(cl_date) != "0") {
    //"1969-07-20 20:18:04Z"
    final String year = cl_date.substring(cl_date.length - 4);
    final String day =
        cl_date.substring(cl_date.length - 8, cl_date.length - 6);
    final String month = getMonthNr(cl_date);
    final String finalDate = "$year-$month-${day.replaceAll(" ", "0")}";

    final DateTime closureDate = DateTime.parse(finalDate);
    final DateTime dateNow =
        DateTime.now().toUtc().add(const Duration(hours: -5));

    if (closureDate.day == dateNow.day &&
        closureDate.month == dateNow.month &&
        closureDate.year == dateNow.year) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

bool isCancled(String des) {
  if (des == "Closure Scheduled" || des == "Intermittent Closure Scheduled") {
    return false;
  } else {
    return true;
  }
}

bool isClosureGone(String cl_date, String cl_time) {
  if (getMonthNr(cl_date) != "0") {
    //"1969-07-20 20:18:04Z"
    final String year = cl_date.substring(cl_date.length - 4);
    final String day =
        cl_date.substring(cl_date.length - 8, cl_date.length - 6);
    final String month = getMonthNr(cl_date);
    final String finalDate = "$year-$month-${day.replaceAll(" ", "0")}";
    final DateTime closureDate = DateTime.parse(finalDate);
    final DateTime dateNow =
        DateTime.now().toUtc().add(const Duration(hours: -6));

    if (closureDate.compareTo(dateNow.add(const Duration(hours: -24))) == -1)
      return true;
    else
      return false;
  } else {
    return false;
  }
}

int getNextActiveClosure(String data) {
  if (data.isNotEmpty) {
    final List descriptions = getClosureInf(data, 5);
    final List times = getClosureInf(data, 4);
    final List dates = getClosureInf(data, 3);

    for (var i = 0; i < getClosureAmount(data); i++) {
      if (!isClosureGone(dates[i], times[i]) && !isCancled(descriptions[i])) {
        return i;
      }
    }
    return -1;
  } else {
    return -1;
  }
}
