import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class WorldTime{
  String location; // location name for the UI
  String time=""; // time in that location
  String flag; // url to an asset flag icon
  String url; // location url for API endpoint
  bool isDaytime = true;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    Uri endpoint = Uri.parse("http://worldtimeapi.org/api/timezone/$url");
    // make request
    try {
      Response response = await get(endpoint);
      Map data = jsonDecode(response.body);
      // get properties from the data
      String datetime = data["datetime"];
      String offset = data["utc_offset"].substring(1, 3);
      // create a dtatetime obj
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      // set the time property
      isDaytime = now.hour > 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print("caught error: $e");
      time = "could not get time data";
    }
  }
}