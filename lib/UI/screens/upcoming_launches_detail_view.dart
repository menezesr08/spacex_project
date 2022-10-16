import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacex_project/UI/upcoming_launches_data.dart';
import 'package:url_launcher/url_launcher.dart';

class UpcomingLaunchesDetailView extends StatelessWidget {
  const UpcomingLaunchesDetailView({Key? key, required this.id})
      : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    context.read<UpcomingLaunchesData>().fetchUpcomingLaunchDetail(id);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail View'),
      ),
      body: Center(
        child: Consumer<UpcomingLaunchesData>(
          builder: (context, value, child) {
            return value.upcomingLaunch == null && !value.error
                ? CircularProgressIndicator()
                : value.error
                    ? Text(
                        value.errorMessage,
                        textAlign: TextAlign.center,
                      )
                    // : Column(
                    //     children: [
                    //       Text(value.upcomingLaunch!.mission.name!),
                    //       Text(value.upcomingLaunch!.mission.rocket!),

                    //     ],
                    //   );
                    : Card(
                        elevation: 50,
                        shadowColor: Colors.black,
                        color: Colors.black12,
                        child: SizedBox(
                          width: 300,
                          height: 480,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.green[500],
                                  radius: 108,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      value.upcomingLaunch!.patch.small ??
                                          'https://i.redd.it/exmspx2e5iz61.png',
                                    ), //NetworkImage
                                    radius: 100,
                                  ), //CircleAvatar
                                ), //CircleAvatar
                                const SizedBox(
                                  height: 10,
                                ), //SizedBox
                                Text(
                                  'Mission: ${value.upcomingLaunch!.mission.name}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ), //Textstyle
                                ), //Text
                                const SizedBox(
                                  height: 10,
                                ), //SizedBox
                                Text(
                                  'Rocket: ${value.upcomingLaunch!.mission.rocket}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.red[900],
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500), //Textstyle
                                ), //Text
                                const SizedBox(
                                  height: 30,
                                ),
                                value.upcomingLaunch!.mission.youtubeId != null
                                    ? ElevatedButton.icon(
                                        icon: Icon(Icons.web),
                                        onPressed: () {
                                          _launchUrl(value.upcomingLaunch!
                                              .mission.youtubeId!);
                                        },
                                        label: const Text('Open youtube'))
                                    : const Text('No youtube link'),

                                const SizedBox(
                                  height: 10,
                                ),
                                IconButton(
                                    onPressed: () async {
                                      await context
                                          .read<UpcomingLaunchesData>()
                                          .favouriteUpcomingLaunch(
                                              value.upcomingLaunch!);
                                    },
                                    icon: value.upcomingLaunch!.isFavourite
                                        ? Icon(
                                            Icons.favorite,
                                            size: 30,
                                            color: Color.fromARGB(
                                                255, 154, 23, 14),
                                          )
                                        : Icon(
                                            Icons.favorite_border,
                                            size: 30,
                                            color:
                                                Color.fromARGB(255, 114, 14, 7),
                                          )), //SizedBox
                              ],
                            ), //Column
                          ), //Padding
                        ),
                      );
          },
        ),
      ),
    );
  }
}

Future<void> _launchUrl(String id) async {
  String url = 'https://www.youtube.com/watch?v=$id';
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}
