import 'package:flutter/material.dart';

import '../../../app_style.dart';
import '../controllers/content_box_controller.dart';

class ContentBox extends StatelessWidget {
  const ContentBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppStyle.padding8,
        vertical: AppStyle.padding16,
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: ContentBoxInfo(),
          ),
          SizedBox(width: AppStyle.padding16),
          Expanded(
            flex: 3,
            child: ContentBoxData(),
          ),
        ],
      ),
    );
  }
}

class ContentBoxInfo extends StatelessWidget {
  const ContentBoxInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/simulations.png',
        ),
        const SizedBox(height: AppStyle.padding16),
        const Text(
          'RECENT SIMULATIONS',
        ),
        const SizedBox(height: AppStyle.padding16),
        Container(
          width: 320,
          padding: const EdgeInsets.all(AppStyle.padding32),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade400,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'An overview of recently finished simulations.',
              ),
              SizedBox(height: AppStyle.padding16),
              Text(
                'Organisation thuyloi-university can use unlimited simulation hours.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ContentBoxData extends StatefulWidget {
  const ContentBoxData({super.key});

  @override
  State<ContentBoxData> createState() => _ContentBoxDataState();
}

class _ContentBoxDataState extends State<ContentBoxData> {
  final controller = ContentBoxController();
  @override
  void initState() {
    super.initState();
    controller.getSimulations();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.isLoading,
      builder: (context, value, child) {
        if (value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return const SimulationDataTable();
      },
    );
  }
}

class SimulationDataTable extends StatelessWidget {
  const SimulationDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ContentBoxController();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ListenableBuilder(
          listenable: controller,
          builder: (context, child) {
            return DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Model')),
                DataColumn(label: Text('User')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Type')),
                DataColumn(label: Text('Start Time')),
                DataColumn(label: Text('Length')),
              ],
              rows: [
                for (final item in controller.simulations)
                  DataRow(cells: [
                    DataCell(Text(item.id)),
                    DataCell(Text(item.name)),
                    DataCell(Text(item.model)),
                    DataCell(Text(item.username)),
                    DataCell(Text(item.status)),
                    DataCell(Text(item.type)),
                    DataCell(Text(item.type)),
                    DataCell(Text(formatTotalTime(item.totalTime))),
                  ]),
              ],
            );
          }),
    );
  }

  String formatTotalTime(int totalTime) {
    if (totalTime > 3600) {
      return '${(totalTime / 3600).toStringAsFixed(2)} giờ';
    } else if (totalTime > 60) {
      return '${(totalTime / 60).toStringAsFixed(2)} phút';
    } else {
      return '${(totalTime).toStringAsFixed(2)} giây';
    }
  }
}
