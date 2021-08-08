import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:rsud_setjo/Screens/Daftar/cek_klinik.dart';
import 'package:rsud_setjo/Screens/Daftar/landing.dart';
import 'package:rsud_setjo/Screens/Daftar/profile.dart';
import 'package:rsud_setjo/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Pendaftaran extends StatefulWidget {
  @override
  _PendaftaranState createState() => _PendaftaranState();
}

class _PendaftaranState extends State<Pendaftaran> {
  TextEditingController norm = new TextEditingController();
  DateTime date;
  var codepoli;
  var rm;
  var tipepasien;
  String getText() {
    if (date == null) {
      return 'Pilih Tanggal Periksa';
    } else {
      return DateFormat('yyyy-MM-dd').format(date);

      //return '${date.month}/${date.day}/${date.year}';
    }
  }

  Future<Null> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1980),
      lastDate: DateTime(2050),
    );
    if (newDate == null) return;

    setState(() => date = newDate);
  }

  final TextEditingController _daftar = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String selectedRadio;
  String choice;
  String nama = "";
  String nohp = "";
  Future getLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nohp = preferences.getString('nohp');
    });
  }

  @override
  void initState() {
    super.initState();
    //selectedRadio = 0;
    getLogin();
  }

  setSelectedRadio(String value) {
    setState(() {
      selectedRadio = value;
      switch (value) {
        case 'bpjs':
          choice = value;
          break;
        case 'umum':
          choice = value;
          break;
        default:
          choice = null;
      }
      print(choice);
    });
  }

  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      backgroundColor: Color(0xFFffffff),
      body: Container(
        padding: const EdgeInsets.only(left: 48, right: 48, top: 10),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "BOOKING ANTRIAN ",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              ),
              Text(
                "PENDAFTARAN RAWAT JALAN",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              ),
              SizedBox(height: height * 0.02),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        value: 'bpjs',
                        groupValue: selectedRadio,
                        activeColor: kPrimaryColor,
                        onChanged: setSelectedRadio,
                      ),
                      Text(
                        'BPJS',
                        style: new TextStyle(fontSize: 17.0),
                      ),
                      Radio(
                        value: 'umum',
                        groupValue: selectedRadio,
                        activeColor: Colors.red,
                        onChanged: setSelectedRadio,
                      ),
                      Text(
                        'UMUM',
                        style: new TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Text(
                'Nomor RM',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: norm,
                decoration: InputDecoration(
                    labelText: "Masukkan 6 Digit Terakhir Nomor RM"),
                keyboardType: TextInputType.number,
                maxLength: 6,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Nomor RM Tidak Boleh Kosong";
                  } else {
                    return null;
                  }
                },
              ),
              //SizedBox(height: height * 0.02),
              Text(
                'Pilih Poli ',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                child: TypeAheadFormField<Poli>(
                  hideSuggestionsOnKeyboardHide: false,
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _daftar,
                    //   decoration: InputDecoration(
                    //       prefixIcon: Icon(Icons.search),
                    //       border: OutlineInputBorder(),
                    //       hintText: 'Pilih Poli Rawat Jalan'),
                  ),
                  suggestionsCallback: PoliApi.getPoliSuggestions,
                  itemBuilder: (context, Poli suggestion) {
                    final listpoli = suggestion;

                    return ListTile(
                      title: Text(listpoli.medunitNm),
                    );
                  },
                  onSuggestionSelected: (Poli suggestion) {
                    final listpoli = suggestion;
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content: Text('Poli Dipilih: ${listpoli.medunitCd}'),
                      ));
                    this._daftar.text = listpoli.medunitNm;
                    this.codepoli = listpoli.medunitCd;
                  },
                ),
              ),
              SizedBox(height: height * 0.01),
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
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.red[400],
                child: Text(
                  getText(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  pickDate(context);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),
                  NeumorphicButton(
                    margin: EdgeInsets.only(top: 12),
                    onPressed: () {
                      if (formKey.currentState.validate()) {}
                      //RegistrasiUser();
                      _showMyDialog();
                    },
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.circle(),
                      color: Colors.red[400],
                    ),
                    child: NeumorphicIcon(
                      Icons.arrow_forward,
                      size: 40,
                    ),
                  )
                ],
              ),
              SizedBox(height: height * 0.03),
              Text(
                "Note : Pendaftaran antrian dimulai H-1 sebelum hari periksa mulai pukul 06.00 - 18.00 ",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    final double height = MediaQuery.of(context).size.height;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: EdgeInsets.all(20),
          title: const Text('MOHON PERIKSA KEMBALI',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Form(
              child: ListBody(
                children: <Widget>[
                  SizedBox(height: height * 0.02),
                  Row(children: [
                    Text(
                      'NOMOR RM :',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                  SizedBox(height: height * 0.01),
                  Row(children: [
                    norm.text == ''
                        ? Text('')
                        : Text(norm.text, style: new TextStyle(fontSize: 17)),
                  ]),
                  SizedBox(height: height * 0.04),
                  Row(children: [
                    Text(
                      'POLI / KLINIK TUJUAN :',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                  SizedBox(height: height * 0.01),
                  Row(children: [
                    _daftar.text == ''
                        ? Text('')
                        : Text(_daftar.text,
                            style: new TextStyle(fontSize: 17)),
                  ]),
                  SizedBox(height: height * 0.04),
                  Row(children: [
                    Text(
                      'TIPE PASIEN :',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                  SizedBox(height: height * 0.01),
                  Row(children: [
                    choice == ''
                        ? Text('')
                        : Text(choice, style: new TextStyle(fontSize: 17)),
                  ]),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('BATAL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('PROSES'),
              onPressed: () {
                RegistrasiUser();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future RegistrasiUser() async {
    var apiURL =
        "http://36.67.10.15:1317/bridging_pendaftaranonline/RegistrasiAntrian.php";

    Map user = {
      "pasientp": choice,
      "nohp": nohp,
      "datetimein": getText(),
      "medunitcd": codepoli,
      "norm": norm.text,
    };
    //print("Json : ${user}");

    http.Response response = await http.post(apiURL, body: user);

    var data = jsonDecode(response.body);
    var message = data['data']['message'];
    //print(message);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('message', message);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return landingPage();
        },
      ),
    );
  }
}
