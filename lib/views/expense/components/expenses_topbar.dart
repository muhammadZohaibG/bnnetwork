import 'package:b_networks/app%20components/KCircle.dart';
import 'package:b_networks/app%20components/KLogo.dart';
import 'package:b_networks/app%20components/KTopBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/KColors.dart';
import '../../../utils/const.dart';
import '../../../utils/keys.dart';
import '../../settings/view/settings_screen.dart';

class ExpensesTopBar extends StatefulWidget {
  const ExpensesTopBar({super.key});

  @override
  State<ExpensesTopBar> createState() => _ExpensesTopBarState();
}

class _ExpensesTopBarState extends State<ExpensesTopBar> {
  String? profileImage = '';

  @override
  void initState() {
    function();
    super.initState();
  }

  function() async {
    profileImage = await getValueInSharedPref(Keys.image);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return KTopBar(
      leftFlex: 2,
      leftWidget: Row(
        children: [
          // KLogo(
          //   logoRadius: 45,
          //   logoFontSize: 16,
          // ),
          InkWell(
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsScreen()))
                  .then((value) => function());
            },
            child: CachedNetworkImage(
                imageUrl: profileImage!,
                imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 20,
                    backgroundColor: primaryColor.withOpacity(0.2),
                    backgroundImage: imageProvider),
                placeholder: (context, url) =>
                    CircularProgressIndicator(color: primaryColor),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: KColors().darkGrey)),
          ),
          const SizedBox(width: 7),
          Text(
            'Expenses',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: kColors.darkGrey,
            ),
          ),
        ],
      ),
      rightWidget: KCircle(
          logoRadius: 45,
          centerWidget: Image.asset(
            "assets/icons/help_icon.png",
            scale: 1.1,
          )),
    );
  }
}
