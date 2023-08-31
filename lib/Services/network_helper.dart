import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:revisionapp/Services/model.dart';

class NetworkHelper {
  Future<TrendingData> getTrendingData() async {
    var trendingModel;
    final response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/trending/all/day'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyN2ZlOGFhMjg1ZTZkMTFjOGIzY2Y1ZmE2Mzg3NThlOSIsInN1YiI6IjYwY2JlN2MwNjY1NDA4MDAzZmQyZjE2YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.yBRlzTJZHnl5s7a5KuOhaMMgNoGt1c3cn3xRMMttcyU'
        });

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      trendingModel = TrendingData.fromJson(decodedData);
      print(trendingModel);
    }
    return trendingModel;
  }
}
