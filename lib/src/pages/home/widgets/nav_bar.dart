import 'package:flutter/material.dart';

import '../../../app_style.dart';
import '../../../services/auth_service.dart';
import '../../login/login_page.dart';
import '../../settings/controllers/settings_controller.dart';
import 'license_form.dart';

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
                  'Phần mềm mô phỏng thủy động lực 1D 2D',
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
                PopupMenuButton(
                  color: AppStyle.whiteColor,
                  tooltip: '',
                  itemBuilder: (_) => [
                    if (!SettingsController().isActive)
                      PopupMenuItem(
                        onTap: () {
                          onActiveButtonPressed(context);
                        },
                        child: const Text('Kích hoạt'),
                      ),
                    PopupMenuItem(
                      onTap: () {},
                      child: const Text('Tài liệu hướng dẫn'),
                    ),
                    PopupMenuItem(
                      onTap: () {},
                      child: const Text('Hỗ trợ'),
                    ),
                  ],
                  child: const Text(
                    'Help',
                    style: TextStyle(
                      color: AppStyle.whiteColor,
                    ),
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
                  tooltip: 'Thao tác với người dùng',
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      onTap: () {},
                      child: const Text('Thông tin người dùng'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        AuthService().logout().then((value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                          );
                        });
                      },
                      child: const Text('Đăng xuất'),
                    ),
                  ],
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppStyle.whiteColor,
                    size: AppStyle.iconSize20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onActiveButtonPressed(BuildContext context) async {
    await showDialog<bool>(
      context: context,
      builder: (_) => const LicenseForm(),
    ).then((isValidLicense) {
      if (isValidLicense == null) {
        return;
      }
      if (isValidLicense == true) {
        showDialog(
          context: context,
          builder: (_) => const SuccessDialog(),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => const ErrorDialog(),
        );
      }
    });
  }
}
