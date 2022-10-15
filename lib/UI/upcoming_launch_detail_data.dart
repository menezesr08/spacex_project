import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:spacex_project/constants.dart';
import 'package:spacex_project/models/launch.dart';
import 'package:http/http.dart' as http;

class UpcomingLaunchDetailData extends ChangeNotifier {
  late Launch _data;
  bool _error = false;
  String _errorMessage = '';

  Launch get data => _data;

  bool get error => _error;
  String get errorMessage => _errorMessage;

  Future<void>  fetchUpcomingLaunchesDetail(String id) async {
    final response = await http.get(Uri.parse(getSingleLaunchUrl + id), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });

    if (response.statusCode == 200) {
      try {
        final launchData = json.decode(response.body);

        _data = Launch.fromJson(launchData);


        _error = false;
      } catch (e) {
        _error = true;
        
      }
    } else {
      _error = true;
      _errorMessage = 'Something went wrong!';
    
    }
    notifyListeners();
  }

  void initialValues() {

    _error = false;
    _errorMessage = '';
    notifyListeners();
  }
}
