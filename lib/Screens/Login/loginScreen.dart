import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rsud_setjo/Screens/Welcome/components/home.dart';
import 'package:rsud_setjo/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

ProgressDialog pr;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ProgressDialog pr;

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<Null> _login() async {
    await pr.show();

    try {
      if (user.text.isNotEmpty && pass.text.isNotEmpty) {
        var response = await http.post(
            Uri.parse(
                'http://36.67.10.15:1317/bridging_pendaftaranonline/Login.php'),
            body: {
              //"status": '200',
              "norm": user.text,
              "nohp": pass.text,
            }).timeout(const Duration(seconds: 2), onTimeout: () {
          pr.hide();
          throw TimeoutException(
              'The connection has timed out, Please try again!');
        });
        if (response.body.isNotEmpty) {
          final datauser = json.decode(response.body);
          pr.hide();
          var nama = datauser['data']['nama'];
          var nohp = datauser['data']['nohpconv'];
          var alamat = datauser['data']['alamat'];
          print(datauser);
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString('norm', user.text);
          preferences.setString('nama', nama);
          preferences.setString('nohp', nohp);
          preferences.setString('alamat', alamat);
          Fluttertoast.showToast(
              msg: "Login Berhasil",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red[900],
              textColor: Colors.white,
              fontSize: 16);
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => Home()));
        } else {
          pr.hide();
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Invalid Akun Anda Belum Terdaftar')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid / Data Masih Kosong')));
      }
    } on TimeoutException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error Gagal Terhubung ke Server')));
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error, Periksa Koneksi Internet Anda')));
    }
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(message: 'Mohon Tunggu...');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Color(0xffffffff),
                Color(0xffffffff),
                Color(0xffffffff),
                Color(0xffffffff),
              ])),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/icons/login.svg",
                    ),
                    Text(
                      "#Pastikan Perangkat Anda Terhubung Internet",
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.03),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Nomor RM',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: [
                                BoxShadow(
                                    color: kPrimaryColor,
                                    blurRadius: 6,
                                    offset: Offset(0, 2))
                              ]),
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: TextField(
                                controller: user,
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14),
                                    prefixIcon: Icon(Icons.person,
                                        color: Colors.teal[200]),
                                    hintText:
                                        'Masukkan 6 Digit Terakhir No. RM',
                                    hintStyle:
                                        TextStyle(color: Colors.black38)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Nomor Hp',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: [
                                BoxShadow(
                                    color: kPrimaryColor,
                                    blurRadius: 6,
                                    offset: Offset(0, 2))
                              ]),
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: TextField(
                                controller: pass,
                                maxLength: 13,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14),
                                    prefixIcon: Icon(Icons.phone_android,
                                        color: Colors.teal[200]),
                                    hintText: 'Masukkan Nomor HP',
                                    hintStyle:
                                        TextStyle(color: Colors.black38)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 40),
                    RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: kPrimaryColor,
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        _login();
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // _showAlertDialog(BuildContext context, String err) {
  //   Widget okButton = MaterialButton(
  //     child: Text("OK"),
  //     onPressed: () => Navigator.pop(context),
  //   );
  //   AlertDialog alert = AlertDialog(
  //     title: Text("Error"),
  //     content: Text(err),
  //     actions: [
  //       okButton,
  //     ],
  //   );
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return alert;
  //       });
  // }
}
