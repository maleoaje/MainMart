import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler {
  String baseurl = "https://umapi.mainmart.com.ng";
  var log = Logger();

  Future get(String url) async {
    url = formatter(url);
    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    url = formatter(url);
    var response = await http.post(url,
        headers: {"Content-type": "application/json"}, body: json.encode(body));
    return response;
  }

  String formatter(String url) {
    return baseurl + url;
  }
}
