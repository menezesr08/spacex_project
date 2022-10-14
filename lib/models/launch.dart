import 'package:spacex_project/models/mission.dart';
import 'package:spacex_project/models/patch.dart';

class Launch {
    Launch({
        required this.mission,
         required this.patch
    });

    final Mission mission;
    final Patch patch;

    factory Launch.fromJson(Map<String, dynamic> json) => Launch(
        mission: Mission.fromJson(json),
        patch: Patch.fromJson(json["links"]["patch"]),
    );
}