import 'package:flutter/material.dart';
import 'package:rsud_setjo/bpjs/formpeserta.dart';
import 'package:rsud_setjo/bpjs/formrujukan.dart';

class cekKepesertaan extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cek Status BPJS"),
      ),
      body: Container(
        child: ListView(
          physics: ClampingScrollPhysics(),
          padding: const EdgeInsets.all(24.0),
          children: <Widget>[
            Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Ink.image(
                    image: AssetImage('assets/images/peserta.png'),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return formPeserta();
                            },
                          ),
                        );
                      },
                    ),
                    height: 230,
                    fit: BoxFit.fitHeight,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Ink.image(
                    image: AssetImage('assets/images/rujukan.png'),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return formRujukan();
                            },
                          ),
                        );
                      },
                    ),
                    height: 250,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
