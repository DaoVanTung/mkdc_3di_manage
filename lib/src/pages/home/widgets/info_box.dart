import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../app_style.dart';
import '../../settings/controllers/settings_controller.dart';
import '../controllers/content_box_controller.dart';

class InfoBox extends StatelessWidget {
  const InfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppStyle.padding8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Material(
        color: AppStyle.whiteColor,
        elevation: 3.0,
        child: Container(
          height: 160,
          padding: const EdgeInsets.all(AppStyle.padding24),
          child: Row(
            children: [
              const Expanded(
                flex: 1,
                child: NumberOfGroup(),
              ),
              const Expanded(
                flex: 1,
                child: NumberOfUser(),
              ),
              Expanded(
                flex: 2,
                child: SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries<UserData, String>>[
                    ColumnSeries<UserData, String>(
                      dataSource: [
                        UserData('1/2024', 35),
                        UserData('2/2024', 28),
                        UserData('3/2024', 34),
                        UserData('4/2024', 32),
                        UserData('5/2024', 40),
                      ],
                      xValueMapper: (UserData users, _) => users.time,
                      yValueMapper: (UserData users, _) => users.length,
                      name: 'Người dùng',
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserData {
  UserData(this.time, this.length);
  final String time;
  final double length;
}

class NumberOfGroup extends StatelessWidget {
  const NumberOfGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
        right: BorderSide(),
      )),
      child: Column(
        children: [
          const Text('Người dùng'),
          const SizedBox(height: AppStyle.padding8),
          ValueListenableBuilder(
            valueListenable: SettingsController().numberOfUser,
            builder: (context, numberOfUser, child) {
              return RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: numberOfUser.toString(),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class NumberOfUser extends StatelessWidget {
  const NumberOfUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Simulation'),
        const SizedBox(height: AppStyle.padding8),
        ValueListenableBuilder(
          valueListenable: ContentBoxController().numberOfSimulation,
          builder: (context, numberOfSimulation, child) {
            return RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: numberOfSimulation.toString(),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
