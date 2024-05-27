import 'package:flutter/material.dart';
import 'package:mkdc_3di_manage/src/app_style.dart';

import 'widgets/alert_box.dart';
import 'widgets/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          NavBar(),
          AlertBox(),
          Expanded(child: ContentLayout()),
          SizedBox(height: AppStyle.padding8),
        ],
      ),
    );
  }
}

class ContentLayout extends StatelessWidget {
  const ContentLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppStyle.padding8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.lightBlue,
                  ),
                ),
                const SizedBox(height: AppStyle.padding8),
                Expanded(
                  child: Container(
                    color: Colors.lightBlue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppStyle.padding8),
          Expanded(
            flex: 7,
            child: Container(
              color: Colors.lightBlue,
            ),
          ),
        ],
      ),
    );
  }
}
