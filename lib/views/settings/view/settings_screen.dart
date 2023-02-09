import 'package:b_networks/views/login/view/login_screen.dart';
import 'package:b_networks/views/settings/components/settings_topbar.dart';
import 'package:b_networks/views/settings/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app components/KMainButton.dart';
import '../../../utils/KColors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors().screenBG,
      body: Column(
        children: [
          Expanded(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SettingsTopBar(),
              ),
            ]),
          ),
          Consumer<SettingsProvider>(
            builder: (context, settingsProvider, child) => KMainButton(
                text: "Logout",
                onPressed: () async {
                  await settingsProvider.logOut();
                  if (!mounted) return;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false);
                }),
          )
        ],
      ),
    );
  }
}
