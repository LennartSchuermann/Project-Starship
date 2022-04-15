// ignore_for_file: non_constant_identifier_names, avoid_print
import 'package:http/http.dart' as http;
import 'package:tankwatcher/Classes/events.dart';
import 'package:tankwatcher/Classes/log.dart';
import 'dart:convert' as convert;

import 'package:tankwatcher/Classes/starship.dart';
import 'package:tankwatcher/Classes/superheavy.dart';
import 'package:tankwatcher/design.dart';

class StarshipService {
  var starship_api = Uri.parse(
      "https://raw.githubusercontent.com/LennartSchuermann/starship_api/main/starship_api.json");
  var superheavy_api = Uri.parse(
      "https://raw.githubusercontent.com/LennartSchuermann/starship_api/main/superheavy_api.json");
  var log_api = Uri.parse(
      "https://raw.githubusercontent.com/LennartSchuermann/starship_api/main/log.json");
  var events_api = Uri.parse(
      "https://raw.githubusercontent.com/LennartSchuermann/starship_api/main/events.json");

  Future<List> fetchStarshipData() async {
    print("Fetching Starships...");
    var response = await http.get(starship_api);
    var json = convert.jsonDecode(response.body);

    print("2/" + kMaxLoadingSteps + " | Done");
    return json;
  }

  Future<List> fetchSuperHeavyData() async {
    print("Fetching Superheavys...");
    var response = await http.get(superheavy_api);
    var json = convert.jsonDecode(response.body);

    print("3/" + kMaxLoadingSteps + " | Done");
    return json;
  }

  Future<List> fetchActivityLogData() async {
    print("Fetching Activity Log...");
    var response = await http.get(log_api);
    var json = convert.jsonDecode(response.body);

    print("4/" + kMaxLoadingSteps + " | Done");
    return json;
  }

  Future<List> fetchEventsData() async {
    print("Fetching Events...");
    var response = await http.get(events_api);
    var json = convert.jsonDecode(response.body);

    print("5/" + kMaxLoadingSteps + " | Done");
    return json;
  }

  List<Starship> getStarshipData(var res, int maxCards) {
    List<Starship> starships = [];

    for (var i = 0; i < maxCards; i++) {
      var starship = Starship.fromJson(res[i]);
      starships.add(starship);
    }
    return starships;
  }

  List<Superheavy> getSuperheavyData(var res, int maxCards) {
    List<Superheavy> boosters = [];

    for (var i = 0; i < maxCards; i++) {
      var superheavy = Superheavy.fromJson(res[i]);
      boosters.add(superheavy);
    }
    return boosters;
  }

  List<ActivityLog> getActivityLogData(var res, int maxCards) {
    List<ActivityLog> logs = [];

    for (var i = 0; i < maxCards; i++) {
      var log = ActivityLog.fromJson(res[i]);
      logs.add(log);
    }
    return logs;
  }

  List<Events> getEventsData(var res, int maxCards) {
    List<Events> events = [];

    for (var i = 0; i < maxCards; i++) {
      var event = Events.fromJson(res[i]);
      events.add(event);
    }
    return events;
  }
}
