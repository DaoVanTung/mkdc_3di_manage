import 'package:flutter/material.dart';
import 'package:mkdc_3di_manage/src/pages/home/home_page.dart';

import '../../app_style.dart';
import '../activate/activate_page.dart';
import '../settings/controllers/settings_controller.dart';
import 'controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginController();
    return Scaffold(
      backgroundColor: AppStyle.whiteColor,
      body: Center(
        child: Material(
          color: Colors.white,
          elevation: 4,
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/logo.webp',
                  width: 80,
                ),
                const SizedBox(
                  height: 8,
                ),
                Image.asset(
                  'assets/images/name_black.webp',
                  width: 120,
                ),
                const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                    'Không có quyền truy cập. Vui lòng đăng nhập để sử dụng dịch vụ này!',
                    textAlign: TextAlign.center,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: controller.isBusy,
                  builder: (context, value, child) {
                    if (value == true) return const CircularProgressIndicator();
                    return ElevatedButton(
                      onPressed: () async {
                        controller.login().then((value) {
                          if (value) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const WrapperPage(),
                              ),
                            );
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStyle.menuColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      child: const Text(
                        'Đăng nhập với MKDC',
                        style: TextStyle(
                          color: AppStyle.whiteColor,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WrapperPage extends StatelessWidget {
  const WrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: SettingsController(),
      builder: (context, child) {
        if (SettingsController().isActive) {
          return const HomePage();
        } else {
          return const ActivatePage();
        }
      },
    );
  }
}
