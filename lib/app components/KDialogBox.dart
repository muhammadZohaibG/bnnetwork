import 'package:b_networks/utils/KColors.dart';
import 'package:flutter/material.dart';

import 'KMainButton.dart';

class KDialogBox {
  KColors kColors = KColors();
  void showDialogBox({
    bool moreButtons = false,
    List<Widget>? buttonWidgets,
    required double dialogBoxHeight,
    String? buttonText,
    VoidCallback? onButtonPress,
    required BuildContext context,
    required List<Widget> widgets,
  }) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceAround,
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Builder(
              builder: (context) {
                var width = MediaQuery.of(context).size.width;
                return SizedBox(
                  height: dialogBoxHeight,
                  width: width - 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widgets,
                    ),
                  ),
                );
              },
            ),
            actions: moreButtons == false
                ? <Widget>[
                    KMainButton(
                      forDialog: true,
                      text: buttonText!,
                      onPressed: onButtonPress!,
                    ),
                  ]
                : buttonWidgets));
  }
}
