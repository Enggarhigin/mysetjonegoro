import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rsud_setjo/Screens/Daftar/dashboard.dart';
import 'package:rsud_setjo/Screens/Login/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/home.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   var nama = preferences.getString('nama');

//   runApp(MaterialApp(
//     home: nama == null ? Home() : Pendaftaran(),
//   ));
// }

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  String nama = "";
  Future getLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nama = preferences.getString('nama');
    });
  }

  void initState() {
    getLogin();
    super.initState();
    Timer(Duration(seconds: 5), () {
      if (nama != null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => Home()));
      } else {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 70,
            ),
            SizedBox(
              height: 10,
            ),
            Text('Sehat Bersama Setjonegoro'),
            SizedBox(
              height: 50,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.teal[700]),
            )
          ],
        ),
      ),
    );
  }
}
