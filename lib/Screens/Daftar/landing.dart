import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rsud_setjo/Screens/Daftar/profile.dart';
import 'package:rsud_setjo/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class landingPage extends StatefulWidget {
  @override
  _landingPageState createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  String message = "";
  Future getDaftar() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      message = preferences.getString('message');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 3,
        title: Image.asset(
          "assets/images/logo.png",
          height: 120.0,
          width: 120.0,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 20),
            child: IconButton(
              icon: Icon(
                Icons.person,
                color: kPrimaryColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Profile();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/icons/login.svg",
            ),
            Text(
              'SELAMAT, ANTRIAN ANDA BERHASIL DIBUAT',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                Wrap(
                    spacing: 8.0, // gap between adjacent chips
                    runSpacing: 4.0, // gap between lines
                    direction: Axis.horizontal,
                    children: [
                      message == ''
                          ? Text('')
                          : Text(
                              message,
                              style: new TextStyle(fontSize: 19),
                            ),
                    ]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void initState() {
    super.initState();
    getDaftar();
  }
}
