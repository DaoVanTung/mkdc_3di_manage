import 'package:flutter/material.dart';

import '../../../app_style.dart';
import '../controllers/settings_controller.dart';

class ApiSetting extends StatelessWidget {
  const ApiSetting({super.key});

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
            children: [
              ApiKeyList(),
              SizedBox(height: AppStyle.padding16),
            ],
          ),
        ),
      ),
    );
  }
}

class ApiKeyList extends StatefulWidget {
  const ApiKeyList({super.key});

  @override
  State<ApiKeyList> createState() => _ApiKeyListState();
}

class _ApiKeyListState extends State<ApiKeyList> {
  final controller = SettingsController();

  @override
  void initState() {
    controller.getApiKeys();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'API Keys',
              style: TextStyle(
                fontSize: AppStyle.fontSize16,
                fontWeight: FontWeight.w600,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                side: BorderSide.none,
                backgroundColor: AppStyle.menuColor,
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.add,
                    size: AppStyle.iconSize20,
                    color: AppStyle.whiteColor,
                  ),
                  SizedBox(width: AppStyle.padding8),
                  Text(
                    'Thêm mới',
                    style: TextStyle(
                      color: AppStyle.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppStyle.padding8),
        ListenableBuilder(
          listenable: controller,
          builder: (context, child) {
            return SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Prefix')),
                    DataColumn(label: Text('Scope')),
                    DataColumn(label: Text('Trạng thái')),
                    DataColumn(label: Text('Ngày tạo')),
                    DataColumn(label: Text('Ngày hết hạn')),
                  ],
                  rows: [
                    for (final item in controller.apiKeys)
                      DataRow(
                        cells: [
                          DataCell(Text(item.name)),
                          DataCell(Text(item.prefix)),
                          DataCell(Text(item.scope)),
                          DataCell(
                            Text(item.revoked ? 'Thu hồi' : 'Đang hoạt động'),
                          ),
                          DataCell(Text(item.created)),
                          DataCell(Text(item.expiryDate ?? '')),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
