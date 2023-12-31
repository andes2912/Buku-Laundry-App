import 'dart:convert';
import 'package:bukulaundry/network/api.dart';
import 'package:http/http.dart' as http;

import 'package:bukulaundry/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<User> fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final response = await http.get(
      Uri.parse(ApiService().baseUrl() + 'profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to load User');
    }
  }
}
