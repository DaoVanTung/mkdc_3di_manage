import 'package:flutter/material.dart';

import '../../app_style.dart';
import 'widgets/content_box.dart';
import 'widgets/info_box.dart';
import 'widgets/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppStyle.whiteColor,
      body: Column(
        children: [
          NavBar(),
          InfoBox(),
          Expanded(child: ContentBox()),
          SizedBox(height: AppStyle.padding16),
        ],
      ),
    );
  }
}
