import 'package:flutter/material.dart';
import 'package:rsud_setjo/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class formPeserta extends StatefulWidget {
  @override
  _formPesertaState createState() => _formPesertaState();
}

class _formPesertaState extends State<formPeserta> {
  TextEditingController user = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cek Kepesertaan"),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 16),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                'Silahkan Masukkan No. BPJS / NIK Anda',
                style: TextStyle(fontSize: 16),
              ),
            ),
            TextFormField(
              controller: user,
              decoration: InputDecoration(
                  hintText: "Masukkan No. BPJS / NIK",
                  labelText: "No. BPJS / NIK",
                  //errorText: _passwordError,
                  labelStyle: TextStyle(
                    fontSize: 24,
                    color: kPrimaryColor,
                  ),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.people)),
              keyboardType: TextInputType.number,
              obscureText: false,
              maxLength: 16,
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
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    final double height = MediaQuery.of(context).size.height;
    final response = await http.post(
        Uri.parse(
            'http://36.67.10.15:1317/bridging_pendaftaranonline/Peserta.php'),
        body: {
          "peserta": user.text,
        });
    var datauser = jsonDecode(response.body);
    print(datauser);
    if (datauser['status'] == 200) {
      var nama = datauser['data']['nama'];
      var nik = datauser['data']['nik'];
      var nopeserta = datauser['data']['nopeserta'];
      var jnskel = datauser['data']['jnskel'];
      var tgllahir = datauser['data']['tgllahir'];
      var kelas = datauser['data']['kelas'];
      var status = datauser['data']['status'];
      var pekerjaan = datauser['data']['pekerjaan'];
      var ppkperujuk = datauser['data']['ppkperujuk'];
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
                        'NIK :',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    //SizedBox(height: height * 0.01),
                    Row(children: [
                      nik == ''
                          ? Text('')
                          : Text(nik, style: new TextStyle(fontSize: 17)),
                    ]),
                    SizedBox(height: height * 0.01),
                    Row(children: [
                      Text(
                        'No Peserta :',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    //SizedBox(height: height * 0.01),
                    Row(children: [
                      nopeserta == ''
                          ? Text('')
                          : Text(nopeserta, style: new TextStyle(fontSize: 17)),
                    ]),
                    SizedBox(height: height * 0.01),
                    Row(children: [
                      Text(
                        'Jenis Kelamin :',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    Row(children: [
                      jnskel == ''
                          ? Text('')
                          : Text(jnskel, style: new TextStyle(fontSize: 17)),
                    ]),
                    SizedBox(height: height * 0.01),
                    Row(children: [
                      Text(
                        'Tanggal Lahir :',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    //SizedBox(height: height * 0.01),
                    Row(children: [
                      tgllahir == ''
                          ? Text('')
                          : Text(tgllahir, style: new TextStyle(fontSize: 17)),
                    ]),
                    SizedBox(height: height * 0.01),
                    Row(children: [
                      Text(
                        'Kelas :',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    //SizedBox(height: height * 0.01),
                    Row(children: [
                      kelas == ''
                          ? Text('')
                          : Text(kelas, style: new TextStyle(fontSize: 17)),
                    ]),
                    SizedBox(height: height * 0.01),
                    Row(children: [
                      Text(
                        'Status :',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    Row(children: [
                      status == ''
                          ? Text('')
                          : Text(status, style: new TextStyle(fontSize: 17)),
                    ]),
                    SizedBox(height: height * 0.01),
                    Row(children: [
                      Text(
                        'Pekerjaan :',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    Row(children: [
                      pekerjaan == ''
                          ? Text('')
                          : Text(pekerjaan, style: new TextStyle(fontSize: 17)),
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
