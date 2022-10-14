import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:spacex_project/constants.dart';
import 'package:spacex_project/models/launch.dart';
import 'package:http/http.dart' as http;

class LaunchData extends ChangeNotifier {
  List<Launch> _data = [];
  bool _error = false;
  String _errorMessage = '';

  List<Launch> get data => _data;
  set data(List<Launch> oldData) {
    data = oldData;
  }

  bool get error => _error;
  String get errorMessage => _errorMessage;

  Future<void> get fetchData async {
    final response = await http.get(Uri.parse(spacexApiUrl), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });

    if (response.statusCode == 200) {
      try {
        final launchData = json.decode(response.body);
        launchData.forEach((entry) {
          _data.add(Launch.fromJson(entry));
        });
        // Sort in descending order - soonest at the top
        data.sort((a, b) => DateTime.parse(b.mission.launchDate!)
            .compareTo(DateTime.parse(a.mission.launchDate!)));

        _error = false;
      } catch (e) {
        _error = true;
        _data = [];
      }
    } else {
      _error = true;
      _errorMessage = 'Something went wrong!';
      _data = [];
    }
    notifyListeners();
  }

  void initialValues() {
    _data = [];
    _error = false;
    _errorMessage = '';
    notifyListeners();
  }
}
