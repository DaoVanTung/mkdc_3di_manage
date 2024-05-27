import 'package:flutter/material.dart';

import '../../../app_style.dart';

class AlertBox extends StatelessWidget {
  const AlertBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppStyle.padding8),
      padding: const EdgeInsets.all(AppStyle.padding16),
      color: AppStyle.dangerColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MKDC - Tiêu đề ứng dụng',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppStyle.padding4),
              Text(
                'MKDC - Mô tả ứng dụng',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          Visibility(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                side: BorderSide.none,
                backgroundColor: Colors.redAccent,
              ),
              child: const Text(
                'Kích hoạt',
                style: TextStyle(
                  color: AppStyle.whiteColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
