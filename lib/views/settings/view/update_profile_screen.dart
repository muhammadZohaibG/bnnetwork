import 'package:b_networks/app%20components/KTextField.dart';
import 'package:b_networks/utils/KColors.dart';
import 'package:b_networks/utils/const.dart';
import 'package:b_networks/views/settings/components/update_screen_components.dart';
import 'package:b_networks/views/settings/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app components/KCircle.dart';
import '../../../app components/KMainButton.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kscreenBG,
      appBar: PreferredSize(
          preferredSize: Size(width(context), 50),
          child: UpdateScreenComponents().topBar()),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) => Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  UpdateScreenComponents().profileImage(
                      imageUrl: settingsProvider.profileImage,
                      onCameraTap: () {}),
                  const SizedBox(height: 50),
                  KTextField(
                      onChanged: (c) {},
                      hintText: 'Full Name',
                      color: Colors.white),
                  const SizedBox(height: 20),
                  KTextField(
                      onChanged: (c) {},
                      hintText: 'Company',
                      color: Colors.white),
                  const SizedBox(height: 20),
                  KTextField(
                    onChanged: (c) {},
                    hintText: 'Email',
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  KTextField(
                      onChanged: (c) {},
                      hintText: 'Phone Number',
                      color: Colors.white),
                  const SizedBox(height: 20),
                  KTextField(
                      onChanged: (c) {},
                      hintText: 'Location',
                      color: Colors.white),
                  const SizedBox(height: 20),
                ],
              ),
            )),
            KMainButton(text: "Update", onPressed: () async {})
          ],
        ),
      ),
    );
  }
}
