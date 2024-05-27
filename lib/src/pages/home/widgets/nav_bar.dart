import 'package:flutter/material.dart';

import '../../../app_style.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: AppStyle.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppStyle.padding8),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Image.asset(
                  'assets/images/logo_with_name_white.webp',
                  width: 120,
                ),
                const SizedBox(width: 8),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: VerticalDivider(
                    color: AppStyle.whiteColor,
                    indent: 8,
                    endIndent: 8,
                  ),
                ),
                Text(
                  'Phần mềm thuộc MKDC chưa có tên',
                  style: Theme.of(context).textTheme.bodyLarge?.apply(
                        color: AppStyle.whiteColor,
                      ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                    color: AppStyle.whiteColor,
                    size: AppStyle.fontSize20,
                  ),
                ),
                const SizedBox(width: AppStyle.padding16),
                const CircleAvatar(
                  radius: AppStyle.padding12,
                  backgroundImage: AssetImage('assets/images/avatar.webp'),
                ),
                const SizedBox(width: AppStyle.padding16),
                PopupMenuButton(
                  color: AppStyle.whiteColor,
                  tooltip: '',
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      onTap: () {},
                      child: const Text('Thông tin người dùng'),
                    ),
                    PopupMenuItem(
                      onTap: () {},
                      child: const Text('Đăng xuất'),
                    ),
                  ],
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppStyle.whiteColor,
                    size: 20,
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
