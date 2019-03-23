import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stories/models.dart';

class NotFoundException implements Exception {
  String cause;
  NotFoundException(this.cause);
}

class Api {
  static String endPoint = "https://api.storiesig.com";

  static Future<ApiResponse> getProfile(String username) async {
    final response = await http.get("$endPoint/stories/$username");
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(json.decode(response.body));
    } else {
      if (response.statusCode == 400) {
        throw NotFoundException("NOT_FOUND");
      }
      throw Exception("Unable to load ${response.toString()}");
    }
  }

  static Future<HighLightsResponse> getHighLights(String username) async {
    final response = await http.get("$endPoint/highlights/$username");
    if (response.statusCode == 200) {
      return HighLightsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Unable to load ${response.toString()}");
    }
  }

  static Future<SingleHighLightResponse> getSingleHighLights(String highlightId) async {
    print("$endPoint/highlights/$highlightId");
    final response = await http.get("$endPoint/highlight/$highlightId");
    print(response);
    if (response.statusCode == 200) {
      return SingleHighLightResponse.fromJson(json.decode(response.body), highlightId);
    } else {
      throw Exception("Unable to load ${response.toString()}");
    }
  }
}
