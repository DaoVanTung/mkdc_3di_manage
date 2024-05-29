import 'package:flutter/material.dart';
import 'package:mkdc_3di_manage/src/pages/settings/widgets/api_setting.dart';
import 'package:mkdc_3di_manage/src/pages/settings/widgets/general_setting.dart';

import '../../app_style.dart';
import '../home/widgets/nav_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.whiteColor,
      body: Column(
        children: [
          const NavBar(),
          Padding(
            padding: const EdgeInsets.all(AppStyle.padding4),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: AppStyle.iconSize20,
                  ),
                ),
                const SizedBox(width: AppStyle.padding8),
                const Text(
                  'Cấu hình',
                  style: TextStyle(
                    fontSize: AppStyle.fontSize16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppStyle.padding16),
          const Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: SettingBoxInfo(),
                ),
                Expanded(
                  flex: 3,
                  child: SettingBoxData(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingBoxInfo extends StatelessWidget {
  const SettingBoxInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/settings.png',
        ),
        const SizedBox(height: AppStyle.padding16),
        const Text(
          'CẤU HÌNH',
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
                'Quản lý thông tin tổ chức, người dùng, API Key và các thông tin khác của ứng dụng.',
              ),
              // SizedBox(height: AppStyle.padding16),
              // Text(
              //   '- Cấu hình chung',
              //   style: TextStyle(
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              // Text(
              //   '- Cấu hình API Key',
              //   style: TextStyle(
              //     fontWeight: FontWeight.w500,
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
  }
}

class SettingBoxData extends StatelessWidget {
  const SettingBoxData({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: TabBar(
              dividerHeight: 0,
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelColor: AppStyle.menuColor,
              dividerColor: AppStyle.menuColor,
              indicatorColor: AppStyle.menuColor,
              tabs: [
                Tab(text: 'Thông tin chung'),
                Tab(text: 'API Key'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                GeneralSetting(),
                ApiSetting(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
