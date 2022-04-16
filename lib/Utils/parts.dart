// ignore_for_file: constant_identifier_names

// Project imports:
import 'package:tankwatcher/Classes/starship.dart';
import 'package:tankwatcher/Classes/superheavy.dart';

Starship getStarshipFleet(List<Starship> starships) {
  for (var starship in starships) {
    if (starship.isFleet) {
      return starship;
    }
  }
  return starships[0];
}

Superheavy getSuperHeavyFleet(List<Superheavy> superheavys) {
  for (var superheavy in superheavys) {
    if (superheavy.isFleet) {
      return superheavy;
    }
  }
  return superheavys[0];
}

//STARSHIP PARTS
const String engine_layout_old =
    'assets/images/starship_parts/engine_layout_old.svg';
const String engine_layout_new =
    'assets/images/starship_parts/engine_layout_new.svg';

const String bottom_flaps =
    'assets/images/starship_parts/bottom_flaps_dummy.svg';
const String starship_bg = 'assets/images/starship_parts/starship_dummy.svg';
const String starship_body = 'assets/images/starship_parts/body_dummy.svg';
const String nose_cone = 'assets/images/starship_parts/nose_cone_dummy.svg';
const String top_flaps = 'assets/images/starship_parts/top_flaps_dummy.svg';

//ENGINES
const String rings = 'assets/images/starship_parts/engines/rings.svg';
//Engine Path
const String enginepath = 'assets/images/starship_parts/engines/';

//SUPERHEAVY PARTS
const String engine_layout_old_sh =
    'assets/images/superheavy_parts/engine_layout_sh_old.svg';
const String engine_layout_new_sh =
    'assets/images/superheavy_parts/engine_layout_sh_new.svg';

//ENGINES
const String shRings = 'assets/images/superheavy_parts/engines/rings.svg';
const String shEnginepath = 'assets/images/superheavy_parts/engines/';





//SUPERHEAVY PARTS superheavy_parts
