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
                    : Column(
                        children: [
                          Text(value.upcomingLaunch!.mission.name!),
                          Text(value.upcomingLaunch!.mission.rocket!),
                          value.upcomingLaunch!.mission.youtubeId != null
                              ? ElevatedButton(
                                  onPressed: () {
                                    _launchUrl(value
                                        .upcomingLaunch!.mission.youtubeId!);
                                  },
                                  child: const Text('Open youtube'))
                              : const Text('No youtube link'),
                          IconButton(
                              onPressed: () async {
                                await context
                                    .read<UpcomingLaunchesData>()
                                    .favouriteUpcomingLaunch(
                                        value.upcomingLaunch!);
                              },
                              icon: value.upcomingLaunch!.isFavourite
                                  ? Icon(Icons.favorite)
                                  : Icon(Icons.favorite_border)),
                        ],
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
