import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for the UI
  String time; // the time in that location
  String flag; //url to an asset flag icon
  String url; // this is the location url for api endpoint
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // make the request
      Uri urlParse = Uri.parse('https://worldtimeapi.org/api/timezone/$url');
      Response response = await get(urlParse);
      Map data = jsonDecode(response.body);

      //get properties from data

      String dateTime = data['datetime'];
      String offset = data['utc_offset'].toString().substring(1, 3);

      // create dateTime Object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDayTime = now.hour>6&& now.hour<20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught Error : $e');
      time = 'could not get time data';
    }
  }
}
