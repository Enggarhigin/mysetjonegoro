import 'package:flutter/material.dart';
import 'package:rsud_setjo/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class formRujukan extends StatefulWidget {
  @override
  _formRujukan createState() => _formRujukan();
}

class _formRujukan extends State<formRujukan> {
  TextEditingController user = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cek Rujukan"),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 16),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                'Masukkan No BPJS Anda',
                style: TextStyle(fontSize: 16),
              ),
            ),
            TextFormField(
              controller: user,
              decoration: InputDecoration(
                  hintText: "Masukkan No. Kartu BPJS",
                  labelText: "No. Kartu BPJS",
                  //errorText: _passwordError,
                  labelStyle: TextStyle(
                    fontSize: 24,
                    color: kPrimaryColor,
                  ),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.people)),
              keyboardType: TextInputType.number,
              obscureText: false,
              maxLength: 13,
            ),
            SizedBox(
              width: 140,
              height: 50,
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                onPressed: () {
                  _showMyDialog();
                },
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Text(
                  "CEK DATA",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    final double height = MediaQuery.of(context).size.height;
    final response = await http.post(
        Uri.parse(
            'http://36.67.10.15:1317/bridging_pendaftaranonline/Rujukan.php'),
        body: {
          "rujukan": user.text,
        });

    var datauser = jsonDecode(response.body);
    //print(datauser);
    if (datauser['status'] == 200) {
      var nomorrujukan = datauser['data']['nomorrujukan'];
      var tanggalrujukan = datauser['data']['tanggalrujukan'];
      var nomorkartu = datauser['data']['nomorkartu'];
      var nama = datauser['data']['nama'];
      var ppkperujuk = datauser['data']['ppkperujuk'];
      var subspesialis = datauser['data']['subspesialis'];
      var berlaku = datauser['data']['berlaku'];
      //print(nama);
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.all(20),
            title: const Text('Hasil Pencairan Data'),
            content: SingleChildScrollView(
              child: Form(
                child: ListBody(
                  children: <Widget>[
                    Row(children: [
                      Text(
                        'Nomor Rujukan :',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    //SizedBox(height: height * 0.01),
                    Row(children: [
                      nomorrujukan == ''
                          ? Text('')
                          : Text(nomorrujukan,
                              style: new TextStyle(fontSize: 17)),
                    ]),
                    SizedBox(height: height * 0.01),
                    Row(children: [
                      Text(
                        'Tanggal Rujukan :',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    //SizedBox(height: height * 0.01),
                    Row(children: [
                      tanggalrujukan == ''
                          ? Text('')
                          : Text(tanggalrujukan,
                              style: new TextStyle(fontSize: 17)),
                    ]),
                    SizedBox(height: height * 0.01),
                    Row(children: [
                      Text(
                        'Nomor Kartu :',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    //SizedBox(height: height * 0.01),
                    Row(children: [
                      nomorkartu == ''
                          ? Text('')
                          : Text(nomorkartu,
                              style: new TextStyle(fontSize: 17)),
                    ]),
                    SizedBox(height: height * 0.01),
                    Row(children: [
                      Text(
                        'Nama :',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    //SizedBox(height: height * 0.01),
                    Row(children: [
                      nama == ''
                          ? Text('')
                          : Text(nama, style: new TextStyle(fontSize: 17)),
                    ]),
                    SizedBox(height: height * 0.01),
                    Row(children: [
                      Text(
                        'PPK Perujuk :',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    //SizedBox(height: height * 0.01),
                    Row(children: [
                      ppkperujuk == ''
                          ? Text('')
                          : Text(ppkperujuk,
                              style: new TextStyle(fontSize: 17)),
                    ]),
                    SizedBox(height: height * 0.01),
                    Row(children: [
                      Text(
                        'Sub Spesialis :',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    Row(children: [
                      subspesialis == ''
                          ? Text('')
                          : Text(subspesialis,
                              style: new TextStyle(fontSize: 17)),
                    ]),
                    SizedBox(height: height * 0.01),
                    Row(children: [
                      Text(
                        'Berlaku :',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    //SizedBox(height: height * 0.01),
                    Row(children: [
                      berlaku == ''
                          ? Text('')
                          : Text(berlaku, style: new TextStyle(fontSize: 17)),
                    ]),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Baiklah'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
