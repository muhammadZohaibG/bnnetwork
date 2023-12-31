import 'dart:developer';

import 'package:b_networks/app%20components/KTextField.dart';
import 'package:b_networks/utils/KColors.dart';
import 'package:b_networks/utils/const.dart';
import 'package:b_networks/views/settings/components/update_screen_components.dart';
import 'package:b_networks/views/settings/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../app components/KMainButton.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {


  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kscreenBG,
      appBar: PreferredSize(
          preferredSize: Size(width(context), 50),
          child: UpdateScreenComponents().topBar()),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      settingsProvider.imageFile != null
                          ? Stack(children: [
                              CircleAvatar(
                                  radius: 50,
                                  backgroundColor:
                                      primaryColor.withOpacity(0.2),
                                  backgroundImage:
                                      Image.file(settingsProvider.imageFile!)
                                          .image),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                      onTap: () {
                                        settingsProvider.clearImage();
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: kscreenBG),
                                          child: const Icon(Icons.close,
                                              color: Colors.black))))
                            ])
                          : UpdateScreenComponents().profileImage(
                              imageUrl: settingsProvider.profileImage,
                              onCameraTap: () {
                                UpdateScreenComponents().showBottomSheet(
                                    context,
                                    onCameraTap: () => settingsProvider
                                        .selectImage(ImageSource.camera),
                                    onGalleryTap: () => settingsProvider
                                        .selectImage(ImageSource.gallery));
                              }),
                      const SizedBox(height: 50),
                      KTextField(
                          onChanged: (c) {},
                          controller: settingsProvider.fullNameController,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'The field is required';
                            }
                            return null;
                          },
                          hintText: 'Full Name',
                          color: Colors.white),
                      const SizedBox(height: 20),
                      KTextField(
                          onChanged: (c) {},
                          hintText: 'Company',
                          controller: settingsProvider.companyController,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'The field is required';
                            }
                            return null;
                          },
                          color: Colors.white),
                      const SizedBox(height: 20),
                      KTextField(
                        enabled: false,
                        controller: settingsProvider.emailController,
                        onChanged: (c) {},
                        hintText: 'Email',
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      KTextField(
                          onChanged: (c) {},
                          hintText: 'Phone Number',
                          keyboardType: TextInputType.phone,
                          controller: settingsProvider.phoneNumberController,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'The field is required';
                            }
                            return null;
                          },
                          color: Colors.white),
                      const SizedBox(height: 20),
                      KTextField(
                          onChanged: (c) {},
                          hintText: 'Address',
                          controller: settingsProvider.addressController,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'The field is required';
                            }
                            return null;
                          },
                          color: Colors.white),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            )),
            settingsProvider.isLoading
                ? CircularProgressIndicator(color: primaryColor)
                : KMainButton(
                    text: "Update",
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        log('call update here ');
                        FocusScope.of(context).requestFocus(FocusNode());
                        bool? res = await settingsProvider.updateProfile();
                        if (res!) {
                          if (!mounted) return;
                          Navigator.pop(context);
                        }
                      }
                    })
          ],
        );
        },
      ),
    );
  }
}
