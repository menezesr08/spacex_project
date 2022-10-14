import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacex_project/UI/launch_data.dart';
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
                          return LauchDataRow(
                            data: value.data[index],
                          );
                        });
          }),
        ),
      ),
    );
  }
}

class LauchDataRow extends StatelessWidget {
  const LauchDataRow({Key? key, required this.data}) : super(key: key);
  final Launch data;
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
              data.patch.small ??
                  'https://studentwork.prattsi.org/infovis/wp-content/uploads/sites/3/2021/02/spacex-tesmanian_1600x.jpg',
            ),
            Text('Mission: ${data.mission.name}'),
            Text('Rocket: ${data.mission.rocket}'),
          ],
        ),
      ),
    );
  }
}
