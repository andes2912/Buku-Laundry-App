import 'package:bukulaundry/constant/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class InfoBalance extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
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
      // ignore: prefer_const_constructors
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isIncome == true ? appGreen : appRed,
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
                // ignore: prefer_const_constructors
                ? Icon(Icons.monetization_on)
                // ignore: prefer_const_constructors
                : Icon(Icons.money_off_sharp),
          ),
          // ignore: prefer_const_constructors
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  isIncome == true ? "Income" : "Outcome",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    color: appWhite,
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(height: 5),
                FittedBox(
                  child: Text(
                    "\ Rp $balance",
                    // ignore: prefer_const_constructors
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
