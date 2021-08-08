import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:rsud_setjo/models/services.dart';

import '../../constants.dart';

class klinikBuka extends StatefulWidget {
  @override
  _klinikBukaState createState() => _klinikBukaState();
}

class _klinikBukaState extends State<klinikBuka> {
  List<MedicalUnit> _list = [];
  var loading = false;

  Future<Null> _fetchData() async {
    loading = true;
    final response = await http.get((Uri.parse(
        'http://36.67.10.15:1317/bridging_pendaftaranonline/KlinikBuka.php')));
    if (response.statusCode == 200) {
      //loading = false;
      final json = await compute(jsonDecode, response.body);
      if (json is Map && json.containsKey('data')) {
        final data = json['data'] as List;
        setState(() {
          loading = false;
          _list = data.map((i) => MedicalUnit.fromJson(i)).toList();
        });
      } else {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text('Data Kosong'),
          ));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
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
      ),
      body: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 10),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 7,
            ),
            Center(
              child: Text(
                'Informasi Klinik Buka Hari Ini',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              DateFormat("dd-MM-yyyy hh:mm:ss").format(DateTime.now()),
              style: TextStyle(
                  color: Colors.red, fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 7,
            ),
            Expanded(
              child: loading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _list.length,
                      itemBuilder: (context, i) {
                        MedicalUnit x = _list[i];
                        return Card(
                          //padding: EdgeInsets.all(10.0),
                          child: ListTile(
                              title: Text(
                                x.medunitNm,
                                style: TextStyle(color: Colors.black),
                              ),
                              subtitle: Text(x.pelayananKlinik,
                                  style: TextStyle(
                                      color: Colors.green[800], fontSize: 15)),
                              trailing:
                                  Icon(Icons.check, color: Colors.green[800])),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<String> _getInfoBuka() async {
  //   http.Response hasil = await http.get(
  //       Uri.encodeFull(
  //           "http://36.67.10.15:1317/bridging_pendaftaranonline/KlinikBuka.php"),
  //       headers: {"Accept": "application/json"});
  //   this.setState(() {
  //     Map<String, dynamic> map = json.decode(hasil.body);
  //     List<dynamic> data = map['data'];
  //     //print(data[0]['medunit_nm']);
  //   });

  //   // final response = await http.post(
  //   //   Uri.parse(
  //   //       'http://36.67.10.15:1317/bridging_pendaftaranonline/KlinikBuka.php'),
  //   // );
  // }
}
