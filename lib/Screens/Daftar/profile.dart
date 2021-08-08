import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rsud_setjo/Screens/Login/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String norm = "";
  String nama = "";
  String nohp = "";
  String alamat = "";
  Future getLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      norm = preferences.getString('norm');
      nama = preferences.getString('nama');
      nohp = preferences.getString('nohp');
      alamat = preferences.getString('alamat');
    });
  }

  @override
  void initState() {
    getLogin();
  }

  Future logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('nama');
    Fluttertoast.showToast(
        msg: "Logout Berhasil",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[900],
        textColor: Colors.white,
        fontSize: 16);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Informasi Akun"),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 48, right: 48, top: 48),
        child: Column(
          children: [
            Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      QrImage(
                        data: norm,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    ]),
              ],
            ),
            SizedBox(height: height * 0.02),
            Column(
              children: <Widget>[
                Row(children: [
                  Text(
                    'Nomor Rekam Medik (RM) :',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
                SizedBox(height: height * 0.01),
                Row(children: [
                  norm == ''
                      ? Text('')
                      : Text(norm, style: new TextStyle(fontSize: 17)),
                ]),
              ],
            ),
            SizedBox(height: height * 0.02),
            Column(
              children: <Widget>[
                Row(children: [
                  Text(
                    'Nama Pemilik Akun :',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
                SizedBox(height: height * 0.01),
                Row(children: [
                  nama == ''
                      ? Text('')
                      : Text(nama, style: new TextStyle(fontSize: 17)),
                ]),
              ],
            ),
            SizedBox(height: height * 0.02),
            Column(
              children: <Widget>[
                Row(children: [
                  Text(
                    'Nomor HP :',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
                SizedBox(height: height * 0.01),
                Row(children: [
                  nohp == ''
                      ? Text('')
                      : Text(nohp, style: new TextStyle(fontSize: 17)),
                ]),
              ],
            ),
            SizedBox(height: height * 0.02),
            Column(
              children: <Widget>[
                Row(children: [
                  Text(
                    'Alamat :',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
                SizedBox(height: height * 0.01),
                Row(children: [
                  alamat == ''
                      ? Text('')
                      : Text(alamat, style: new TextStyle(fontSize: 17)),
                ]),
              ],
            ),
            SizedBox(height: height * 0.04),
            Column(
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: kPrimaryColor,
                  child: Text(
                    'LOGOUT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    logOut();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
