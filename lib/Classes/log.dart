class ActivityLog {
  String date;
  List changes;

  ActivityLog({required this.date, required this.changes});

  ActivityLog.fromJson(Map<dynamic, dynamic> parsedJson)
      : date = parsedJson['date'],
        changes = parsedJson['changes'];
}
