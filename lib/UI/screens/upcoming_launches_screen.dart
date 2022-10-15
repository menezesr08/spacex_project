import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacex_project/UI/screens/upcoming_launches_detail_view.dart';
import 'package:spacex_project/UI/upcoming_launches_data.dart';
import 'package:spacex_project/UI/widgets/upcoming_launches_data_row.dart';
import 'package:spacex_project/models/launch.dart';

class UpcomingLaunchesScreen extends StatelessWidget {
  const UpcomingLaunchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<UpcomingLaunchesData>().fetchUpcomingLaunchesData;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'See all the Spacex Launches!',
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<UpcomingLaunchesData>().initialValues();
                context.read<UpcomingLaunchesData>().fetchUpcomingLaunchesData;
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<UpcomingLaunchesData>().fetchUpcomingLaunchesData;
        },
        child: Center(
          child:
              Consumer<UpcomingLaunchesData>(builder: (context, value, child) {
            return value.upcomingLaunches.isEmpty && !value.error
                ? CircularProgressIndicator()
                : value.error
                    ? Text(
                        '${value.errorMessage}',
                        textAlign: TextAlign.center,
                      )
                    : ListView.builder(
                        itemCount: value.upcomingLaunches.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpcomingLaunchesDetailView(
                                            id:value.upcomingLaunches[index].mission.id!)),
                              );
                            },
                            child: UpcomingLaunchesDataRow(
                              data: value.upcomingLaunches[index],
                            ),
                          );
                        });
          }),
        ),
      ),
    );
  }
}
