// ignore_for_file: avoid_print

// Package imports:
import 'package:web_scraper/web_scraper.dart';

// Project imports:
import 'package:tankwatcher/classes/fetchservice.dart';
import 'package:tankwatcher/design.dart';

final webScraper = WebScraper('https://www.cameroncountytx.gov/');

Future<List> getData() async {
  final List data = [];
  final String closureData = await getClosures();
  data.add(closureData);

  final starshipService = StarshipService();
  final List starshipData = await starshipService.fetchStarshipData();
  final List superheavyData = await starshipService.fetchSuperHeavyData();
  data.add(starshipData);
  data.add(superheavyData);

  final List logData = await starshipService.fetchActivityLogData();
  data.add(logData);

  final List eventData = await starshipService.fetchEventsData();
  data.add(eventData);

  print("Ready");
  return data;
}

Future<String> getClosures() async {
  print("Fetching Closure Data...");
  List<Map<String, dynamic>> elements = [];
  List<Map<String, dynamic>> rightElements = [];
  if (await webScraper.loadWebPage('spacex/')) {
    final List<String> content = webScraper.getPageContent().split(" ");
    for (final item in content) {
      if (item.contains("vc_row-") && !item.contains("vc_row-fluid")) {
        final String newid = item.replaceAll('id="', "").replaceAll('"', "");
        //print(newid);
        final String newAdress =
            "#$newid> div > div > div > div.gem-table.gem-table-responsive.gem-table-style-1 > table > tbody'";

        elements = webScraper.getElement(newAdress, []);

        if (elements.isNotEmpty) {
          print("1/$kMaxLoadingSteps | Done");
          rightElements = elements;
        }
      }
    }

    //false elements -> table has &nbsp; tag...
    /* print("DATA:" +
        rightElements
            .toString()
            .replaceAll("[{title:", "")
            .replaceAll(", attributes: {}}]", "")); */
    return rightElements
        .toString()
        .replaceAll("[{title:", "")
        .replaceAll(", attributes: {}}]", "");
  } else {
    return "null";
  }
}

//start = 2: title; 3: date; 4: time; 5:des

List getClosureInf(String data, int start) {
  final List titles = [];
  final List dataList = data.split("\n");

  for (var i = start; i < dataList.length; i += 6) {
    titles.add(dataList[i]);
  }
  return titles;
}

int getClosureAmount(String data) {
  final List dataList = data.split("\n");
  //print((dataList.length / 6).round());
  return (dataList.length / 6).round();
}
