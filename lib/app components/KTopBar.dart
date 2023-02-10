import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import '../utils/KColors.dart';

class KTopBar extends StatelessWidget {
  int leftFlex;
  int middleFlex;
  Widget? leftWidget;
  Widget? midWidget;
  Widget? rightWidget;
  IconData? backArrowIcon;
  bool backArrow;
  bool loginPage;
  KTopBar(
      {super.key,
      this.leftWidget,
      this.leftFlex = 0,
      this.middleFlex = 0,
      this.midWidget,
      this.rightWidget,
      this.backArrow = false,
      this.loginPage = false,
      this.backArrowIcon});

  @override
  Widget build(BuildContext context) {
    KColors kColors = KColors();
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: leftFlex,
              child: backArrow == true
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              loginPage == true
                                  ? SystemNavigator.pop()
                                  : Navigator.pop(context);
                            },
                            child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: kColors.primary.withOpacity(0.15),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50))),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 10,
                                      top: 8,
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: kColors.primary,
                                        size: 15,
                                      ),
                                    )
                                  ],
                                )),
                          ),
                          const SizedBox(width: 10),
                          leftWidget ?? Container(),
                        ],
                      ),
                    )
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: leftWidget ?? Container(),
                    )),
          Expanded(
              flex: middleFlex,
              child: Align(
                alignment: Alignment.center,
                child: midWidget ?? Container(),
              )),
          Expanded(
              child: Align(
            alignment: Alignment.centerRight,
            child: rightWidget ?? Container(),
          )),
        ],
      ),
    );
  }
}
