import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacex_project/UI/launches_data.dart';
import 'package:spacex_project/UI/widgets/launches_data_row.dart';
import 'package:spacex_project/models/launch.dart';

class LaunchesPage extends StatelessWidget {
  const LaunchesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LaunchData>().fetchData;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'See all the Spacex Launches!',
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<LaunchData>().initialValues();
                context.read<LaunchData>().fetchData;
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<LaunchData>().fetchData;
        },
        child: Center(
          child: Consumer<LaunchData>(builder: (context, value, child) {
            return value.data.isEmpty && !value.error
                ? CircularProgressIndicator()
                : value.error
                    ? Text(
                        '${value.errorMessage}',
                        textAlign: TextAlign.center,
                      )
                    : ListView.builder(
                        itemCount: value.data.length,
                        itemBuilder: (context, index) {
                          return LaunchesDataRow(
                            data: value.data[index],
                          );
                        });
          }),
        ),
      ),
    );
  }
}
