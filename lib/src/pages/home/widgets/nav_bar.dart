// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../app_style.dart';
import '../../../services/auth_service.dart';
import '../../login/login_page.dart';
import '../../settings/settings_page.dart';
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
                  'Phần mềm mô phỏng thủy động lực - MKDC 3Di Water Simulation',
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
                      onTap: () {
                        showAboutDialog(context);
                      },
                      child: const Text('Giới thiệu'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SettingsPage(),
                          ),
                        );
                      },
                      child: const Text('Cấu hình'),
                    ),
                    // PopupMenuItem(
                    //   onTap: () {},
                    //   child: const Text('Tài liệu hướng dẫn'),
                    // ),
                    // PopupMenuItem(
                    //   onTap: () {},
                    //   child: const Text('Hỗ trợ'),
                    // ),
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

  void showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: Container(
            width: 480,
            color: AppStyle.whiteColor,
            padding: const EdgeInsets.all(AppStyle.padding16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/license.png'),
                const SizedBox(height: AppStyle.padding16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppStyle.padding16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/correct.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(height: AppStyle.padding16),
                      const Text(
                        'Kích hoạt thành công',
                        style: TextStyle(
                          fontSize: AppStyle.fontSize16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppStyle.padding8),
                      const Text(
                        'Giấy phép của bạn có hiệu lực đến: 30/06/2027',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppStyle.padding16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(_);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        side: BorderSide.none,
                        backgroundColor: AppStyle.menuColor,
                      ),
                      child: const Text(
                        'Đóng',
                        style: TextStyle(
                          color: AppStyle.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
