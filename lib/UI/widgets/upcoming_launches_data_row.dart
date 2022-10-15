import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/material.dart';
import 'package:spacex_project/UI/screens/upcoming_launches_detail_view.dart';
import 'package:spacex_project/models/launch.dart';

class UpcomingLaunchesDataRow extends StatefulWidget {
  const UpcomingLaunchesDataRow({Key? key, required this.data})
      : super(key: key);
  final Launch data;

  @override
  State<UpcomingLaunchesDataRow> createState() =>
      _UpcomingLaunchesDataRowState();
}

class _UpcomingLaunchesDataRowState extends State<UpcomingLaunchesDataRow> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              widget.data.patch.small ??
                  'https://studentwork.prattsi.org/infovis/wp-content/uploads/sites/3/2021/02/spacex-tesmanian_1600x.jpg',
            ),
            Text('Mission: ${widget.data.mission.name}'),
            Text('Rocket: ${widget.data.mission.rocket}'),
            CountDownText(
              due: DateTime.parse(widget.data.mission.launchDate!),
              finishedText: "Done",
              showLabel: true,
              longDateName: true,
              daysTextLong: " DAYS ",
              hoursTextLong: " HOURS ",
              minutesTextLong: " MINUTES ",
              secondsTextLong: " SECONDS ",
              style: TextStyle(color: Colors.blue),
            ),
            widget.data.isFavourite
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
          ],
        ),
      ),
    );
  }
}
