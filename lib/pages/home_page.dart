// ignore_for_file: prefer_const_constructors

import 'package:bukulaundry/constant/colors.dart';
import 'package:bukulaundry/pages/dashboard_page.dart';
import 'package:bukulaundry/pages/location_page.dart';
import 'package:bukulaundry/pages/message_page.dart';
import 'package:bukulaundry/pages/notification_page.dart';
import 'package:bukulaundry/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bukulaundry/pages/login_page.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class HomePage extends StatefulWidget {
  // final String name;
  // final String token;

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedpage = 0;
  final _pageNo = [
    DashboardPage(),
    NotificationPage(),
    LocationPage(),
    MessagesPage(),
    ProfilePage()
  ];

  var url = 'https://andridesmana.vercel.app/images/me.jpeg';
  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.remove('token');
    });

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => PageLogin(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          shadowColor: appBlueSoft.withOpacity(0.2),
          backgroundColor: appBlueSoft.withOpacity(0.2),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(url),
            backgroundColor: Colors.greenAccent,
          ),
          leadingWidth: 40,

          centerTitle: false,
          title: Center(
              child: Text(
            "Welcome,",
            style: TextStyle(color: appBlack),
          )),

          // ignore: prefer_const_literals_to_create_immutables
          actions: [
            IconButton(
              onPressed: () => logOut(),
              icon: Icon(Icons.logout),
              color: appBlack,
            )
          ],
        ),
        body: _pageNo[selectedpage],
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: appWhite,
          color: appPrimary,
          activeColor: appPrimary,
          items: const [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.map, title: 'Pesanan'),
            TabItem(icon: Icons.add, title: 'Customer'),
            TabItem(icon: Icons.message, title: 'Pesan'),
            TabItem(icon: Icons.people, title: 'Profile'),
          ],
          initialActiveIndex: selectedpage,
          onTap: (int index) {
            setState(() {
              selectedpage = index;
            });
          },
        ),
      ),
    );
  }
}
