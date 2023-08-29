import 'dart:developer';
import 'dart:io';
import 'package:b_networks/DBHelpers/bills.dart';
import 'package:b_networks/DBHelpers/connections.dart';
import 'package:b_networks/DBHelpers/expenses.dart';
import 'package:b_networks/DBHelpers/locations.dart';
import 'package:b_networks/models/bill_model.dart';
import 'package:b_networks/models/connection_model.dart';
import 'package:b_networks/models/expense_model.dart';
import 'package:b_networks/models/location_model.dart';
import 'package:b_networks/utils/KColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/const.dart';
import '../../../utils/keys.dart';

class SettingsProvider extends ChangeNotifier {
  var billsDb = Bills();
  var locationsDb = Locations();
  var connectionsDb = Connections();
  var expensesDb = Expenses();
  bool isLoading = false;
  String? email = '';
  String? profileImage = 'assets/images/login_image.png';
  String? fullName = '';
  String? company = '';
  String? phoneNumber = '';
  String? address = '';
  bool? notificationsSwitch = false;
  bool? backup = false;
  List<BillModel> billsList = [];
  List<LocationModel> locationsList = [];
  List<ConnectionModel> connectionsList = [];
  List<ExpenseModel> expenses = [];

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  File? imageFile;
  XFile? pickedFile;

  updateLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  updateNotificationSwitch(bool? value) {
    notificationsSwitch = value;
    notifyListeners();
  }

  addInList(List<dynamic> list, dynamic value) {
    list.add(value);
    notifyListeners();
  }

  Future selectImage(ImageSource source) async {
    pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      imageFile = File(pickedFile!.path);
      notifyListeners();
      log(imageFile!.path.split('/').last);
    }
  }

  clearImage() {
    pickedFile = null;
    imageFile = null;
    notifyListeners();
  }

  Future userDetails() async {
    try {
      updateLoading(true);
      email = await getValueInSharedPref(Keys.email);
      profileImage = await getValueInSharedPref(Keys.image);
      log(profileImage!);
      fullName = await getValueInSharedPref(Keys.name);
      company = await getValueInSharedPref(Keys.companyName);
      phoneNumber = await getValueInSharedPref(Keys.mobile);
      address = await getValueInSharedPref(Keys.address);
      backup = await getIsSyncInSharedPref();
      log('fullName: $fullName \ncompany: $company \nphoneNumber: $phoneNumber \naddress: $address');
      fullNameController.text = fullName!;
      emailController.text = email!;
      companyController.text = company!;
      addressController.text = address!;
      phoneNumberController.text = phoneNumber!;

      notifyListeners();
      updateLoading(false);
    } catch (e) {
      log(e.toString());
      updateLoading(false);
    }
  }

  Future<bool>? updateProfile() async {
    try {
      updateLoading(true);
      await firestore.collection("users").doc(currentUser!.uid).update({
        'mobile': phoneNumberController.value.text,
        'name': fullNameController.value.text,
        'company_name': companyController.value.text,
        'address': addressController.value.text,
        'profile_picture': imageFile != null ? imageFile!.path : ''
      });
      // Map<String, dynamic>? userDetails = await updateProfileRequest(
      //     phoneNumber: phoneNumberController.value.text,
      //     fullName: fullNameController.value.text,
      //     companyName: companyController.value.text,
      //     address: addressController.value.text,
      //     image: imageFile != null ? imageFile!.path : '');
      log(userDetails.toString());
      await storeInSharedPref(
        Keys.name,
        fullNameController.value.text,
      );
      await storeInSharedPref(Keys.image, imageFile!.path);
      await storeInSharedPref(Keys.companyName, companyController.value.text);
      await storeInSharedPref(
        Keys.address,
        addressController.value.text,
      );
      await storeInSharedPref(
        Keys.mobile,
        phoneNumberController.value.text,
      );
      showToast('Profile Updated!', backgroundColor: primaryColor);
      updateLoading(false);
      clearImage();
      return true;
      clearImage();
      updateLoading(false);
      return false;
    } catch (e) {
      log(e.toString());
      updateLoading(false);
      return false;
    }
  }

  Future getUnSynchronizedData() async {
    try {
      //Firebase connected synchronization process
      addIsSyncInSharedPref(Keys.isSync, true);
      notifyListeners();
      // Synchronization process used by previous developer
      // List<Map<String, dynamic>> billsTable = await billsDb.getUnSynchronized();
      // //log(billsTable.toList().toString());
      // for (var e in billsTable) {
      // addInList(billsList, BillModel.fromJson(e));
      // }
      // List<Map<String, dynamic>> locationsTable =
      //     await locationsDb.getUnSynchronized();
      // log('locations ====================>>>>>>>');
      // log(locationsTable.toList().toString());

      // List<Map<String, dynamic>> connectionTable =
      //     await connectionsDb.getUnSynchronized();
      // // log('connections ====================>>>>>>>');
      // // log(connectionTable.toList().toString());

      // List<Map<String, dynamic>> expensesTable =
      //     await expensesDb.getUnSynchronized();
      // // log('expenses ====================>>>>>>>');
      // // log(expensesTable.toList().toString());
      // Map<String, dynamic> data = {
      //   "locations_list": locationsTable,
      //   "connections_list": connectionTable,
      //   "bills_list": billsTable,
      //   "expenses_list": expensesTable
      // };
      // log(data.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  Future logOut() async {
    try {
      await GoogleSignIn().signOut();
      // await firebaseAuth.signOut();
      await clearInSharedPref(Keys.email);
      await clearInSharedPref(Keys.name);
      await clearInSharedPref(Keys.image);
      await clearInSharedPref(Keys.token);
      String? name = await getValueInSharedPref(Keys.name);
      log(name!);
    } catch (e) {
      log(e.toString());
    }
  }

  Future addCurrentMonthBills() async {
    try {
      List<Map<String, dynamic>> table = await billsDb.addCurrentMonthBills();
    } catch (e) {
      log(e.toString());
    }
  }
}
