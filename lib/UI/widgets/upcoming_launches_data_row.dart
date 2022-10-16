import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/material.dart';
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
      elevation: 50,
      shadowColor: Colors.black,
      color: Colors.black12,
      child: SizedBox(
        width: 300,
        height: 440,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green[500],
                radius: 108,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.data.patch.small ??
                        'https://i.redd.it/exmspx2e5iz61.png',
                  ), //NetworkImage
                  radius: 100,
                ), //CircleAvatar
              ), //CircleAvatar
              const SizedBox(
                height: 10,
              ), //SizedBox
              Text(
                'Mission: ${widget.data.mission.name}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ), //Textstyle
              ), //Text
              const SizedBox(
                height: 10,
              ), //SizedBox
              Text(
                'Rocket: ${widget.data.mission.rocket}',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.red[900],
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500), //Textstyle
              ), //Text
              const SizedBox(
                height: 30,
              ),
              const Text('Launching in...',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              CountDownText(
                due: DateTime.parse(widget.data.mission.launchDate!),
                finishedText: "Done",
                showLabel: true,
                longDateName: true,
                daysTextLong: " DAYS ",
                hoursTextLong: " HOURS ",
                minutesTextLong: " MINUTES ",
                secondsTextLong: " SECONDS ",
                style: TextStyle(
                  color: Colors.red[900],
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              widget.data.isFavourite
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border), //SizedBox
            ],
          ), //Column
        ), //Padding
      ), //SizedBox
    );
  }
}
