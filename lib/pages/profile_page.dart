// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';

import 'package:bukulaundry/constant/colors.dart';
import 'package:bukulaundry/widgets/info_saldo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bukulaundry/models/user_model.dart';

Future<User> fetchUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");

  final response = await http.get(
    Uri.parse('http://127.0.0.1:3001/api/profile'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  final output = jsonDecode(response.body)['data'];
  print(output);
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body)['data']);
  } else {
    throw Exception('Failed to load User');
  }
}

void main() => runApp(const ProfilePage());

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBlue,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(70), // Image radius
                  child: Image.network(
                    'https://andridesmana.vercel.app/images/me.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder<User>(
                future: futureUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data!.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: appWhite,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "Software Enggineer",
                style: TextStyle(fontSize: 12, color: appVioletSoft),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: appWhite,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Data Pemasukan",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InfoBalance(isIncome: true, balance: 900000),
                            InfoBalance(isIncome: false, balance: 45000),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
