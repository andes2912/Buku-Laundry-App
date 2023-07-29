import 'package:bukulaundry/pages/dashboard_page.dart';
import 'package:bukulaundry/pages/location_page.dart';
import 'package:bukulaundry/pages/message_page.dart';
import 'package:bukulaundry/pages/notification_page.dart';
import 'package:bukulaundry/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bukulaundry/pages/login_page.dart';
import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';

class HomePage extends StatefulWidget {
  final String name;
  final String token;

  const HomePage({super.key, required this.name, required this.token});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.remove('token');
    });

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const PageLogin(),
      ),
      (route) => false,
    );

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text(
        "Berhasil logout",
        style: TextStyle(fontSize: 16),
      )),
    );
  }

  int _selectedIndex = 0;
  late Widget _selectedWidget;

  @override
  void initState() {
    _selectedWidget = const DashboardPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text("Welcome, ${widget.name}"),
        //   actions: [
        //     IconButton(
        //         onPressed: () => logOut(),
        //         icon: const Icon(Icons.logout_outlined))
        //   ],
        // ),
        body: _selectedWidget,
        bottomNavigationBar: DiamondBottomNavigation(
          itemIcons: const [
            Icons.home,
            Icons.notifications,
            Icons.message,
            Icons.account_box,
          ],
          centerIcon: Icons.place,
          selectedIndex: _selectedIndex,
          onItemPressed: onPressed,
        ),
      ),
    );
  }

  void onPressed(index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        _selectedWidget = const DashboardPage();
      } else if (index == 1) {
        _selectedWidget = const NotificationPage();
      } else if (index == 2) {
        _selectedWidget = const LocationPage();
      } else if (index == 3) {
        _selectedWidget = const MessagesPage();
      } else if (index == 4) {
        _selectedWidget = const ProfilePage();
      }
    });
  }
}
