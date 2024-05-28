import 'package:flutter/material.dart';

import '../../app_style.dart';
import 'widgets/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          NavBar(),
          Expanded(child: ContentLayout()),
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
      margin: const EdgeInsets.all(AppStyle.padding8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                  ),
                ),
                const SizedBox(height: AppStyle.padding8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppStyle.padding8),
          Expanded(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
