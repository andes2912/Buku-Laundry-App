// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:bukulaundry/constant/colors.dart';
import 'package:bukulaundry/models/user_model.dart';
import 'package:bukulaundry/pages/dashboard_page.dart';
import 'package:bukulaundry/pages/location_page.dart';
import 'package:bukulaundry/pages/message_page.dart';
import 'package:bukulaundry/pages/notification_page.dart';
import 'package:bukulaundry/pages/profile_page.dart';
import 'package:bukulaundry/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bukulaundry/pages/login_page.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<User> futureUser;

  int selectedpage = 0;
  final _pageNo = [
    DashboardPage(),
    NotificationPage(),
    LocationPage(),
    MessagesPage(),
    ProfilePage()
  ];

  var url = 'https://andridesmana.vercel.app/images/me.jpeg';

  @override
  void initState() {
    super.initState();
    futureUser = UserService().fetchUser();
  }

  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.remove('token');
    });

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
            child: FutureBuilder<User>(
              future: futureUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: Text(
                      "Welcome, ${snapshot.data!.name}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: appWhite,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
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
