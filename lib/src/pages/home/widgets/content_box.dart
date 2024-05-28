import 'package:flutter/material.dart';

import '../../../app_style.dart';

class ContentBox extends StatelessWidget {
  const ContentBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppStyle.padding8),
    );
  }
}
