import 'dart:developer';

import 'package:b_networks/utils/const.dart';
import 'package:b_networks/utils/text_style.dart';
import 'package:b_networks/views/login/view/login_screen.dart';
import 'package:b_networks/views/settings/components/components.dart';
import 'package:b_networks/views/settings/components/settings_topbar.dart';
import 'package:b_networks/views/settings/provider/settings_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  void initState() {
    function();
    super.initState();
  }

  function() {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      settingsProvider.userDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors().screenBG,
      appBar: PreferredSize(
        preferredSize: Size(width(context), 50),
        child: SettingsTopBar(),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(height: 30),
                    settingsProvider.isLoading
                        ? const SizedBox()
                        : SettingsScreenComponents().profileImage(
                            imageUrl: settingsProvider.profileImage!),
                    const SizedBox(height: 20),
                    Text(settingsProvider.name!,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(settingsProvider.email!,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: KColors().darkGrey.withOpacity(0.4))),
                    const SizedBox(height: 30),
                    const Divider(height: 2, thickness: 5, color: Colors.white),
                    const SizedBox(height: 30),
                    SettingsScreenComponents().tile(
                        leadingIcon: 'assets/icons/notifications.png',
                        title: 'Get Updated',
                        subTitle: 'Notifications',
                        showTrailingSwitch: true,
                        trailingValue: settingsProvider.notificationsSwitch,
                        onChanged: (v) {
                          settingsProvider.updateNotificationSwitch(v);
                        }),
                    const SizedBox(height: 10),
                    SettingsScreenComponents().syncTile(
                        leadingIcon: 'assets/icons/language.png',
                        title: 'Backup',
                        isSync: settingsProvider.backup,
                        onSyncTap: () async {
                          await settingsProvider.getUnSynchronizedData();
                        }),
                    const SizedBox(height: 10),
                    SettingsScreenComponents().tile(
                      leadingIcon: 'assets/icons/language.png',
                      title: 'Language',
                      subTitle: 'English',
                    ),
                    const SizedBox(height: 10),
                    SettingsScreenComponents().tile(
                        leadingIcon: 'assets/icons/terms.png',
                        title: 'Need Help',
                        subTitle: 'Terms and Conditions',
                        tileOnTap: () {
                          launchUrlCustomTab(termsAndConditionsUrl);
                        }),
                    const SizedBox(height: 10),
                    SettingsScreenComponents().tile(
                        leadingIcon: 'assets/icons/logout.png',
                        subTitle: 'LOGOUT',
                        tileOnTap: () async {
                          bool? checkNetwork = await isNetworkAvailable();
                          if (checkNetwork) {
                            await settingsProvider.logOut();
                            if (!mounted) return;
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false);
                          } else {
                            showToast(noInternetConnection);
                          }
                        }),
                    // SettingsScreenComponents().addFreeButton(),
                  ]),
                )),
                //   KMainButton(text: "Logout", onPressed: () async {})
              ],
            ),
          );
        },
      ),
    );
  }
}
