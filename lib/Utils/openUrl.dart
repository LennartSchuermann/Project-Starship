// ignore_for_file: file_names

import 'package:url_launcher/url_launcher.dart';

openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw "Couldn't launch given url!";
  }
}
