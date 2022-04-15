class Superheavy {
  String serialnumber, status, location, imgsource, imglink, purpose;
  int cryoproof, staticfire, flights, landings, starshipnr, raptorCount;
  List parts, sea;
  bool isFleet;

  Superheavy(
      {required this.serialnumber,
      required this.status,
      required this.location,
      required this.imglink,
      required this.imgsource,
      required this.cryoproof,
      required this.staticfire,
      required this.flights,
      required this.landings,
      required this.starshipnr,
      required this.parts,
      required this.sea,
      required this.isFleet,
      required this.raptorCount,
      required this.purpose});

  Superheavy.fromJson(Map<dynamic, dynamic> parsedJson)
      : serialnumber = parsedJson['serialnumber'],
        status = parsedJson['status'],
        purpose = parsedJson['purpose'],
        isFleet = parsedJson['isFleet'],
        parts = parsedJson['parts'],
        imgsource = parsedJson['img_source'],
        cryoproof = parsedJson['cryo_proof'],
        staticfire = parsedJson['static_fire'],
        location = parsedJson['location'],
        flights = parsedJson['orb-flights'],
        landings = parsedJson['landings'],
        starshipnr = parsedJson['starship_nr'],
        imglink = parsedJson['img'],
        raptorCount = parsedJson['raptor_config'],
        sea = parsedJson['sea_raptors'];
}
