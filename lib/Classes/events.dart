class Events {
  String date, title, location;
  bool isDone;

  Events(
      {required this.date,
      required this.title,
      required this.location,
      required this.isDone});

  Events.fromJson(Map<dynamic, dynamic> parsedJson)
      : date = parsedJson['date'],
        title = parsedJson['title'],
        location = parsedJson['location'],
        isDone = parsedJson['isDone'];
}
