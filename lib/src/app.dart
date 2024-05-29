import 'package:flutter/material.dart';

import 'pages/login/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      // home: HomePage(),

      // home: ListenableBuilder(
      //   listenable: SettingsController(),
      //   builder: (context, child) {
      //     if (SettingsController().isActive) {
      //       return const HomePage();
      //     } else {
      //       return const ActivatePage();
      //     }
      //   },
      // ),
    );
  }
}
