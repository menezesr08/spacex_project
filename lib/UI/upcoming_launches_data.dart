import 'dart:convert';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:spacex_project/constants.dart';
import 'package:spacex_project/models/launch.dart';
import 'package:http/http.dart' as http;

class UpcomingLaunchesData extends ChangeNotifier {
  List<Launch> upcomingLaunches = [];
  Launch? upcomingLaunch;
  bool _error = false;
  String _errorMessage = '';

  bool get error => _error;
  String get errorMessage => _errorMessage;

  // Gets data from the spaceX v4 api endpoint: /launches/upcoming
  Future<void> fetchUpcomingLaunchesData() async {
    final response = await http.get(Uri.parse(getAllLaunchesUrl), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });

    if (response.statusCode == 200) {
      try {
        final launchData = json.decode(response.body);
        launchData.forEach((entry) {
          upcomingLaunches.add(Launch.fromJson(entry));
        });
        // Sort in ascending order - soonest at the top
        upcomingLaunches.sort((a, b) => DateTime.parse(a.mission.launchDate!)
            .compareTo(DateTime.parse(b.mission.launchDate!)));
        // Filter for launches after DateTime.now - remove redundant data
        upcomingLaunches = upcomingLaunches
            .where((element) => DateTime.parse(element.mission.launchDate!)
                .isAfter(DateTime.now()))
            .toList();

        _error = false;
      } catch (e) {
        _error = true;
        upcomingLaunches = [];
      }
    } else {
      _error = true;
      _errorMessage = 'Something went wrong!';
      upcomingLaunches = [];
    }
    notifyListeners();
  }
  // Gets data from the spaceX v4 api endpoint: launches/{id}
  Future<void> fetchUpcomingLaunchDetail(String id) async {
    final response =
        await http.get(Uri.parse(getSingleLaunchUrl + id), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });

    if (response.statusCode == 200) {
      try {
        final launchData = json.decode(response.body);

        upcomingLaunch = Launch.fromJson(launchData);
        upcomingLaunch!.isFavourite = upcomingLaunches
            .firstWhere(
                (element) => element.mission.id == upcomingLaunch!.mission.id)
            .isFavourite;

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

  Future<void> favouriteUpcomingLaunch(Launch selectedLaunch) async {
    selectedLaunch.isFavourite = !selectedLaunch.isFavourite;
    // Favourite the upcoming launch on the main screen 
    Launch selectedUpcomingLaunch = upcomingLaunches.firstWhere(
        (element) => element.mission.id == selectedLaunch.mission.id);
    selectedUpcomingLaunch.isFavourite = !selectedUpcomingLaunch.isFavourite;
    notifyListeners();
  }

  void initialValues() {
    upcomingLaunches = [];
    _error = false;
    _errorMessage = '';
    notifyListeners();
  }
}
