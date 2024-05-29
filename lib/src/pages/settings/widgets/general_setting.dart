import 'package:flutter/material.dart';

import '../../../app_style.dart';
import '../controllers/settings_controller.dart';

class GeneralSetting extends StatelessWidget {
  const GeneralSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppStyle.padding16),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(AppStyle.padding16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrgInfo(),
              SizedBox(height: AppStyle.padding32),
              UserList(),
              SizedBox(height: AppStyle.padding16),
            ],
          ),
        ),
      ),
    );
  }
}

class OrgInfo extends StatelessWidget {
  const OrgInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tổ chức',
          style: TextStyle(
            fontSize: AppStyle.fontSize16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: AppStyle.padding8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppStyle.padding16),
          child: Row(
            children: [
              Expanded(flex: 1, child: Text('Tên:')),
              Expanded(
                flex: 13,
                child: Text(
                  'MKDC-SIMCENTER',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppStyle.padding8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppStyle.padding16),
          child: Row(
            children: [
              Expanded(flex: 1, child: Text('UUID:')),
              Expanded(
                flex: 13,
                child: Text(
                  '0d41c6f8e6184a0b9f763814f67b8497',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Danh sách người dùng',
          style: TextStyle(
            fontSize: AppStyle.fontSize16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppStyle.padding8),
        SizedBox(
          width: double.infinity,
          child: ListenableBuilder(
            listenable: controller,
            builder: (context, child) {
              return SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Tên người dùng')),
                    DataColumn(label: Text('Họ')),
                    DataColumn(label: Text('Tên')),
                    DataColumn(label: Text('Email')),
                  ],
                  rows: [
                    for (final item in controller.users)
                      DataRow(
                        cells: [
                          DataCell(Text(item.id.toString())),
                          DataCell(Text(item.username)),
                          DataCell(Text(item.firstName)),
                          DataCell(Text(item.lastName)),
                          DataCell(Text(item.email)),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
