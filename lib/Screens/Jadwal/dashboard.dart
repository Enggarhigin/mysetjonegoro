import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rsud_setjo/Screens/Daftar/profile.dart';
import 'package:rsud_setjo/Screens/Jadwal/buka.dart';
import 'package:rsud_setjo/Screens/Jadwal/tutup.dart';
import 'package:rsud_setjo/constants.dart';
import 'package:intl/intl.dart';
import 'package:rsud_setjo/models/daftarpoli.dart';

class jadwalDokter extends StatelessWidget {
  String getText() {
    var now = new DateTime.now();
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
        margin: EdgeInsets.only(left: 16, right: 16, top: 10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.only(left: 16),
                      height: 64,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: kPrimaryLightColor, width: 1),
                      ),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/icons/clinik.svg',
                            fit: BoxFit.contain,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Info Klinik Buka',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return klinikBuka();
                          },
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.only(left: 16),
                      height: 64,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: kPrimaryLightColor, width: 1),
                      ),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/icons/rs.svg',
                            fit: BoxFit.contain,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'info Klinik Tutup',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return klinikTutup();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              'Jadwal Pelayanan Poli Klinik',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            const Divider(
              color: kPrimaryColor,
              height: 16,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            Text(
              DateFormat("dd-MM-yyyy hh:mm:ss").format(DateTime.now()),
              style: TextStyle(
                  color: Colors.red, fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const Divider(
              color: kPrimaryColor,
              height: 16,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            Text(
              'Pendaftaran H-1 sebelum hari periksa (06.00 sd 18.00)',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 7,
            ),
            Expanded(
              child: ListView.builder(
                  //shrinkWrap: true,
                  itemCount: poliList.length,
                  itemBuilder: (context, index) {
                    Poli poli = poliList[index];
                    return Card(
                      child: ListTile(
                          title: Text(poli.title),
                          subtitle:
                              Text(poli.dokter, style: TextStyle(fontSize: 11)),
                          leading: Image.asset(poli.image),
                          trailing: Icon(Icons.arrow_forward_rounded)),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
