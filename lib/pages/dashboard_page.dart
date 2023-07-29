import 'package:bukulaundry/constant/colors.dart';
import 'package:bukulaundry/widgets/card.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Backgorund
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [appYellowSoft, appPrimary],
            )),
          ),
          const SafeArea(
              child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(),
                    Row(
                      children: [
                        // IconButton(
                        //     onPressed: null,
                        //     icon: Icon(
                        //       Icons.keyboard_arrow_down_rounded,
                        //       color: appPrimary,
                        //     )),
                        Text(
                          "Andri Desmana",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.notifications_active,
                          color: appPrimary,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Saldo Saat Ini"),
              SizedBox(height: 10),
              Text(
                "IDR 900.000",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoBalance(isIncome: true, balance: 900000),
                  InfoBalance(isIncome: false, balance: 45000)
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
