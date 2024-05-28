// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../app_style.dart';
import '../../settings/controllers/settings_controller.dart';

class AlertBox extends StatelessWidget {
  const AlertBox({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: SettingsController(),
      builder: (context, child) {
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
                visible: !SettingsController().isActive,
                child: OutlinedButton(
                  onPressed: () async {
                    final isValidLicense = await showDialog<bool>(
                      context: context,
                      builder: (_) => const LicenseForm(),
                    );

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
                  },
                  style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    side: BorderSide.none,
                    backgroundColor: AppStyle.menuColor,
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
      },
    );
  }
}

class LicenseForm extends StatefulWidget {
  const LicenseForm({super.key});

  @override
  State<LicenseForm> createState() => _LicenseFormState();
}

class _LicenseFormState extends State<LicenseForm> {
  final licenseTextCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 480,
        color: AppStyle.whiteColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppStyle.padding8),
              color: AppStyle.menuColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Giấy phép',
                    style: TextStyle(
                      color: AppStyle.whiteColor,
                      fontWeight: FontWeight.w400,
                      fontSize: AppStyle.fontSize16,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: AppStyle.iconSize20,
                      color: AppStyle.whiteColor,
                    ),
                    splashRadius: AppStyle.iconSize20,
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(AppStyle.padding16),
              child: Column(
                children: [
                  const Text(
                    'Vui lòng nhập license để sử dụng đầy đủ tính năng của ứng dụng!',
                  ),
                  const SizedBox(height: AppStyle.padding16),
                  TextFormField(
                    controller: licenseTextCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.only(),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.only(),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.only(),
                        borderSide: BorderSide(color: Colors.grey.shade500),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppStyle.padding8,
                      ),
                      hintText: 'e.g. XXXX-XXXX-XXXX',
                    ),
                    style: const TextStyle(
                      fontSize: AppStyle.fontSize14,
                    ),
                  ),
                  const SizedBox(height: AppStyle.padding16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Lấy license người dùng nhập
                        final license = licenseTextCtrl.text.toUpperCase();
                        final isValidLicense =
                            SettingsController().updateLicense(
                          license,
                        );
                        Navigator.pop(context, isValidLicense);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        side: BorderSide.none,
                        backgroundColor: AppStyle.menuColor,
                      ),
                      child: const Text(
                        'Xác nhận',
                        style: TextStyle(
                          color: AppStyle.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 480,
        padding: const EdgeInsets.all(AppStyle.padding32),
        color: AppStyle.whiteColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/correct.png'),
            const SizedBox(height: AppStyle.padding16),
            const Text(
              'Kích hoạt thành công!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            const Text(
              'Giấy phép của bạn sẽ hết hạn sau 30/06/2027',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 480,
        padding: const EdgeInsets.all(AppStyle.padding32),
        color: AppStyle.whiteColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/cross.png'),
            const SizedBox(height: AppStyle.padding16),
            const Text(
              'Giấy phép không chính xác hoặc đã hết hạn.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            const Text(
              'Vui lòng kiểm tra lại giấy phép của bạn hoặc thử lại sau!',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
