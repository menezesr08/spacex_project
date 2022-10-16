import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacex_project/UI/screens/upcoming_launches_detail_view.dart';
import 'package:spacex_project/UI/upcoming_launches_data.dart';
import 'package:spacex_project/UI/widgets/upcoming_launches_data_row.dart';

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
              icon: const Icon(Icons.refresh))
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
                ? const CircularProgressIndicator()
                : value.error
                    ? Text(
                        value.errorMessage,
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
                                            id: value.upcomingLaunches[index]
                                                .mission.id!)),
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
