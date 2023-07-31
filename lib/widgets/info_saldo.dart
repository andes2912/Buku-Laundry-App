// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:bukulaundry/constant/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class InfoBalance extends StatelessWidget {
  InfoBalance({
    Key? key,
    required this.isIncome,
    required this.balance,
  }) : super(key: key);

  final bool isIncome;

  final int balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.4,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color:
            isIncome == true ? appBlue.withBlue(130) : appGreen.withAlpha(220),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: appWhite,
              borderRadius: BorderRadius.circular(13),
            ),
            child: isIncome == true
                ? Icon(Icons.monetization_on)
                : Icon(Icons.money_off_sharp),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  isIncome == true ? "Income" : "Outcome",
                  style: TextStyle(
                    color: appWhite,
                  ),
                ),
                SizedBox(height: 5),
                FittedBox(
                  child: Text(
                    "\ Rp $balance",
                    style: TextStyle(
                      color: appWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
