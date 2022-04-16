// ignore_for_file: avoid_multiple_declarations_per_line

class Starship {
  String serialnumber, status, location, imgsource, imglink, purpose;
  int cryoproof, staticfire, flights, landings, boosternr;
  List parts, heatshielded, vac, sea;
  bool isFleet;

  Starship({
    required this.serialnumber,
    required this.status,
    required this.location,
    required this.imglink,
    required this.imgsource,
    required this.cryoproof,
    required this.staticfire,
    required this.flights,
    required this.landings,
    required this.boosternr,
    required this.parts,
    required this.heatshielded,
    required this.vac,
    required this.sea,
    required this.purpose,
    required this.isFleet,
  });

  Starship.fromJson(Map<dynamic, dynamic> parsedJson)
      : serialnumber = parsedJson['serialnumber'],
        status = parsedJson['status'],
        isFleet = parsedJson['isFleet'],
        purpose = parsedJson['purpose'],
        parts = parsedJson['parts'],
        imgsource = parsedJson['img_source'],
        cryoproof = parsedJson['cryo_proof'],
        staticfire = parsedJson['static_fire'],
        location = parsedJson['location'],
        heatshielded = parsedJson['heatshielded'],
        flights = parsedJson['orb-flights'],
        landings = parsedJson['landings'],
        boosternr = parsedJson['booster_nr'],
        imglink = parsedJson['img'],
        vac = parsedJson['raptor_config']['vac'],
        sea = parsedJson['raptor_config']['sea'];
}
