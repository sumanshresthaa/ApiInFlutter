import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:revisionapp/weather_datamodel.dart';

class NetworkHelper {
  Future fetchWeatherData() async {
    http.Response response = await http.post(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=27.7172&lon=85.3240&appid=e5f001d6384ceb15b0c91d7965838d53'));

    //response.statusCode => 200 , 400 , 500
    //response.body => jsonData {}, []
    print("flag 3");
    if (response.statusCode == 200) {
      //converting response to json Data
      //repeating steps
      var decodedData = jsonDecode(response.body);

      return WeatherData.fromJson(decodedData);
      //return the response to ui
    } else {
      //throw exception
    }
  }
}



/*WeatherNews weatherNewsFromJson(String str) => WeatherNews.fromJson(json.decode(str));

 

String weatherNewsToJson(WeatherNews data) => json.encode(data.toJson()); */