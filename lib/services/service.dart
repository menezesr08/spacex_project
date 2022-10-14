import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:spacex_project/constants.dart';
import 'package:spacex_project/models/launch.dart';
import 'package:http/http.dart' as http;

Future<List<Launch?>> getLaunchData() async {
  List<Launch?> result = [];

  try {
    final response = await http.get(Uri.parse(spacexApiUrl), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    if (response.statusCode == 200) {
      final launchData = json.decode(response.body);

      launchData.forEach((entry) {
        result.add(Launch.fromJson(entry));
      });
    }
  } catch (e) {
    log(e.toString());
  }

  return result;
}
