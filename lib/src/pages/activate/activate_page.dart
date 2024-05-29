// ignore_for_file: use_build_context_synchronously

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../app_style.dart';
import '../home/home_page.dart';
import '../home/widgets/license_form.dart';
import '../settings/controllers/settings_controller.dart';

class ActivatePage extends StatelessWidget {
  const ActivatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.whiteColor,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(AppStyle.padding32),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/license.png'),
              const SizedBox(height: AppStyle.padding12),
              const Text(
                'Vui lòng nhập giấy phép được cung cấp để truy cập ứng dụng.',
              ),
              const SizedBox(height: AppStyle.padding32),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    final stringData = await result.xFiles.first.readAsString();
                    final isActivate =
                        SettingsController().updateLicense(stringData);
                    if (isActivate == true) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomePage(),
                        ),
                      );
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
                  } else {
                    // User canceled the picker
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(),
                  side: BorderSide.none,
                  backgroundColor: AppStyle.menuColor,
                ),
                child: const Text(
                  'Chọn tệp giấy phép',
                  style: TextStyle(
                    color: AppStyle.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
