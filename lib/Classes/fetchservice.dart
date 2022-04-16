// ignore_for_file: non_constant_identifier_names, avoid_print

// Dart imports:
import 'dart:convert' as convert;

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:tankwatcher/Classes/events.dart';
import 'package:tankwatcher/Classes/log.dart';
import 'package:tankwatcher/Classes/starship.dart';
import 'package:tankwatcher/Classes/superheavy.dart';
import 'package:tankwatcher/design.dart';

class StarshipService {
  Uri starship_api = Uri.parse(
    "https://raw.githubusercontent.com/LennartSchuermann/starship_api/main/starship_api.json",
  );
  Uri superheavy_api = Uri.parse(
    "https://raw.githubusercontent.com/LennartSchuermann/starship_api/main/superheavy_api.json",
  );
  Uri log_api = Uri.parse(
    "https://raw.githubusercontent.com/LennartSchuermann/starship_api/main/log.json",
  );
  Uri events_api = Uri.parse(
    "https://raw.githubusercontent.com/LennartSchuermann/starship_api/main/events.json",
  );

  Future<List> fetchStarshipData() async {
    print("Fetching Starships...");
    final response = await http.get(starship_api);
    final json = convert.jsonDecode(response.body);

    print("2/$kMaxLoadingSteps | Done");
    return json;
  }

  Future<List> fetchSuperHeavyData() async {
    print("Fetching Superheavys...");
    final response = await http.get(superheavy_api);
    final json = convert.jsonDecode(response.body);

    print("3/$kMaxLoadingSteps | Done");
    return json;
  }

  Future<List> fetchActivityLogData() async {
    print("Fetching Activity Log...");
    final response = await http.get(log_api);
    final json = convert.jsonDecode(response.body);

    print("4/$kMaxLoadingSteps | Done");
    return json;
  }

  Future<List> fetchEventsData() async {
    print("Fetching Events...");
    final response = await http.get(events_api);
    final json = convert.jsonDecode(response.body);

    print("5/$kMaxLoadingSteps | Done");
    return json;
  }

  List<Starship> getStarshipData(var res, int maxCards) {
    final List<Starship> starships = [];

    for (var i = 0; i < maxCards; i++) {
      final starship = Starship.fromJson(res[i]);
      starships.add(starship);
    }
    return starships;
  }

  List<Superheavy> getSuperheavyData(var res, int maxCards) {
    final List<Superheavy> boosters = [];

    for (var i = 0; i < maxCards; i++) {
      final superheavy = Superheavy.fromJson(res[i]);
      boosters.add(superheavy);
    }
    return boosters;
  }

  List<ActivityLog> getActivityLogData(var res, int maxCards) {
    final List<ActivityLog> logs = [];

    for (var i = 0; i < maxCards; i++) {
      final log = ActivityLog.fromJson(res[i]);
      logs.add(log);
    }
    return logs;
  }

  List<Events> getEventsData(var res, int maxCards) {
    final List<Events> events = [];

    for (var i = 0; i < maxCards; i++) {
      final event = Events.fromJson(res[i]);
      events.add(event);
    }
    return events;
  }
}
