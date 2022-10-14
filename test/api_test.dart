import 'package:flutter_test/flutter_test.dart';
import 'package:spacex_project/models/launch.dart';
import 'package:spacex_project/services/service.dart';

void main() {
  test('Launch data is not empty', () async {
    List<Launch?>? launchData;
    launchData = await getLaunchData();
    expect(launchData, isNotEmpty);
  });
}
