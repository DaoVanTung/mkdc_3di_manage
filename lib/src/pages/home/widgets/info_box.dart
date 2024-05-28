import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../app_style.dart';

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
                        UserData('January', 35),
                        UserData('February', 28),
                        UserData('March', 34),
                        UserData('April', 32),
                        UserData('May', 40),
                        UserData('June', 45),
                        UserData('July', 52),
                        UserData('August', 48),
                        UserData('September', 42),
                        UserData('October', 38),
                        UserData('November', 30),
                        UserData('December', 25),
                      ],
                      xValueMapper: (UserData users, _) => users.time,
                      yValueMapper: (UserData users, _) => users.length,
                      name: 'Users',
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
          const Text('Groups'),
          const SizedBox(height: AppStyle.padding24),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: '2',
                  style: TextStyle(
                    fontSize: AppStyle.fontSize32,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextSpan(
                  text: ' of 25',
                  style: TextStyle(
                    fontSize: AppStyle.fontSize20,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
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
        const Text('Users'),
        const SizedBox(height: AppStyle.padding24),
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: '52',
                style: TextStyle(
                  fontSize: AppStyle.fontSize32,
                  fontWeight: FontWeight.w300,
                ),
              ),
              TextSpan(
                text: ' of 150',
                style: TextStyle(
                  fontSize: AppStyle.fontSize20,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
