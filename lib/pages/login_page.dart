import 'dart:convert';

import 'package:bukulaundry/widgets/dialogs.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bukulaundry/pages/home_page.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PageLoginState createState() => _PageLoginState();
}

class HeadClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _PageLoginState extends State<PageLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var txtEditEmail = TextEditingController();
  var txtEditPwd = TextEditingController();

  Widget inputEmail() {
    return TextFormField(
        cursorColor: Colors.white,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        validator: (email) => email != null && !EmailValidator.validate(email)
            ? 'Masukkan email yang valid'
            : null,
        controller: txtEditEmail,
        onSaved: (String? val) {
          txtEditEmail.text = val!;
        },
        decoration: InputDecoration(
          hintText: 'Masukkan Email',
          hintStyle: const TextStyle(color: Colors.white),
          labelText: "Masukkan Email",
          labelStyle: const TextStyle(color: Colors.white),
          prefixIcon: const Icon(
            Icons.email_outlined,
            color: Colors.white,
          ),
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
        style: const TextStyle(fontSize: 16.0, color: Colors.white));
  }

  Widget inputPassword() {
    return TextFormField(
      cursorColor: Colors.white,
      keyboardType: TextInputType.text,
      autofocus: false,
      obscureText: true, //make decript inputan
      validator: (String? arg) {
        if (arg == null || arg.isEmpty) {
          return 'Password harus diisi';
        } else {
          return null;
        }
      },
      controller: txtEditPwd,
      onSaved: (String? val) {
        txtEditPwd.text = val!;
      },
      decoration: InputDecoration(
        hintText: 'Masukkan Password',
        hintStyle: const TextStyle(color: Colors.white),
        labelText: "Masukkan Password",
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: Colors.white,
        ),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
      style: const TextStyle(fontSize: 16.0, color: Colors.white),
    );
  }

  void _validateInputs() {
    if (_formKey.currentState!.validate()) {
      //If all data are correct then save data to out variables
      _formKey.currentState!.save();
      doLogin(txtEditEmail.text, txtEditPwd.text);
    }
  }

  doLogin(email, password) async {
    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.loading(context, keyLoader, "Proses ...");

    try {
      final response =
          await http.post(Uri.parse("http://127.0.0.1:3001/api/login"),
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: jsonEncode({
                "email": email,
                "password": password,
              }));

      final output = jsonDecode(response.body);
      // ignore: avoid_print
      print(output['data']);
      if (output['code'] == 200) {
        // Mengambil data token
        final token = jsonDecode(response.body)['data'];

        // Mengambil data user
        // ignore: unused_local_variable
        final user = jsonDecode(response.body);

        //menyimpan data token
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        //berpindah halaman
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            // ignore: prefer_const_constructors
            builder: (context) => HomePage(),
          ),
          (route) => false,
        );

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            output['message'],
            style: const TextStyle(fontSize: 16),
          )),
        );
      } else {
        Navigator.of(keyLoader.currentContext!, rootNavigator: false).pop();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            output.toString(),
            style: const TextStyle(fontSize: 16),
          )),
        );
      }
    } catch (e) {
      Navigator.of(keyLoader.currentContext!, rootNavigator: false).pop();
      Dialogs.popUp(context, '$e');
      debugPrint('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        margin: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blueAccent, Color.fromARGB(255, 21, 236, 229)],
        )),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ClipPath(
                clipper: HeadClipper(),
                child: Container(
                  margin: const EdgeInsets.all(0),
                  width: double.infinity,
                  height: 180,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text(
                  "Buku Laundry",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      inputEmail(),
                      const SizedBox(height: 20.0),
                      inputPassword(),
                      const SizedBox(height: 5.0),
                    ],
                  )),
              Container(
                padding:
                    const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: const BorderSide(color: Colors.blue),
                        ),
                        elevation: 10,
                        minimumSize: const Size(200, 58)),
                    onPressed: () => _validateInputs(),
                    icon: const Icon(
                      Icons.arrow_right_alt,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "MASUK",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
