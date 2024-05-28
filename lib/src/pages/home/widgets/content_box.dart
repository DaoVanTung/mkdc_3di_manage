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
            child: ContentBoxDataTable(),
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

class ContentBoxDataTable extends StatelessWidget {
  const ContentBoxDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ContentBoxController();
    controller.getSimulations();
    return ValueListenableBuilder(
      valueListenable: controller.result,
      builder: (context, value, child) {
        return Center(
          child: Text(controller.result.value),
        );
      },
    );
  }
}
