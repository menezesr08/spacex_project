import 'package:spacex_project/models/patch.dart';

class Mission {
    Mission({
        required this.name,
         required this.rocket,
         required this.patch
    });

    final String name;
    final String rocket;
    final Patch patch;

    factory Mission.fromJson(Map<String, dynamic> json) => Mission(
        name: json[0]["name"] ?? "",
        rocket: json[0]["rocket"] ?? "",
        patch: Patch.fromJson(json["links"]["patch"]),
    );
}