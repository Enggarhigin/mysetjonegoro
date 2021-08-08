import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rsud_setjo/Screens/Daftar/dashboard.dart';
import 'package:rsud_setjo/Screens/Daftar/profile.dart';
import 'package:rsud_setjo/Screens/Fitur/tempattidur.dart';
import 'package:rsud_setjo/Screens/Jadwal/dashboard.dart';
import 'dart:async';
import 'package:rsud_setjo/bpjs/peserta.dart';
import 'package:rsud_setjo/constants.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:rsud_setjo/models/carousels_model.dart';
import 'package:rsud_setjo/models/layanan_unggulan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String nama = "";
  Future getLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nama = preferences.getString('nama');
    });
  }

  @override
  void initState() {
    super.initState();
    getLogin();
  }

  //int _currentIndex = 0;
  int _current = 0;
  //PageController _pageController;

  final List<Widget> screens = [
    Pendaftaran(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home();

  get children => null;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
      floatingActionButton: buildNavigateButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, top: 10),
              child: nama == ''
                  ? Text('')
                  : Text(
                      nama,
                      style: mTitleStyle,
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 16, top: 6),
              child: Text(
                'Hi' '👋 Nice To Meet You !',
                style: mTitleStyle,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 210,
                    child: Swiper(
                      onIndexChanged: (index) {
                        setState(() {
                          _current = index;
                        });
                      },
                      autoplay: true,
                      layout: SwiperLayout.DEFAULT,
                      itemCount: carousels.length,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: AssetImage(
                                    carousels[index].image,
                                  ),
                                  fit: BoxFit.cover)),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: map<Widget>(
                          carousels,
                          (index, image) {
                            return Container(
                              alignment: Alignment.centerLeft,
                              height: 6,
                              width: 6,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == index
                                      ? kPrimaryColor
                                      : kPrimaryLightColor),
                            );
                          },
                        ),
                      ),

                      // //More
                      // Text(
                      //   'More....',
                      // )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 20),
              child: Text(
                'Kesembuhan Anda Adalah Kepuasan Kami !',
                style: mTitleStyle,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 16, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.only(right: 5),
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kPrimaryColor),
                        child: Center(
                          child: Text(
                            'Jadwal Dokter',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return jadwalDokter();
                            },
                          ),
                        );
                      },
                    ),
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.only(right: 5),
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kPrimaryColor),
                        child: Center(
                          child: Text(
                            'Tempat Tidur',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return KamarTidur();
                            },
                          ),
                        );
                      },
                    ),
                    InkWell(
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kPrimaryColor),
                        child: Center(
                          child: Text(
                            'Informasi Publik',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: () {
                        print('cek3');
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 10),
              child: Text(
                'Sehat Bersama Setjonegoro !',
                style: mTitleStyle,
              ),
            ),
            Container(
              height: 144,
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: kPrimaryLightColor, width: 1),
                            ),
                            child: Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  'assets/icons/bpjs.svg',
                                  fit: BoxFit.contain,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'BPJS',
                                        style: mServiceTitleStyle,
                                      ),
                                      Text(
                                        'Cek BPJS Anda',
                                        style: mServiceSubtitleStyle,
                                      )
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
                                  return cekKepesertaan();
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: kPrimaryLightColor, width: 1),
                            ),
                            child: Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  'assets/icons/nik.svg',
                                  fit: BoxFit.contain,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'SIJAGO',
                                        style: mServiceTitleStyle,
                                      ),
                                      Text(
                                        'Ambulans Gratis',
                                        style: mServiceSubtitleStyle,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            print('cek ktp');
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.only(left: 16),
                            height: 64,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: kPrimaryLightColor, width: 1),
                            ),
                            child: Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  'assets/icons/riwayat.svg',
                                  fit: BoxFit.contain,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Riwayat',
                                        style: mServiceTitleStyle,
                                      ),
                                      Text(
                                        'Lihat Riwayat Pendaftaran',
                                        style: mServiceSubtitleStyle,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            print('riwayat');
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: kPrimaryLightColor, width: 1),
                            ),
                            child: Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  'assets/icons/about.svg',
                                  fit: BoxFit.contain,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Info',
                                        style: mServiceTitleStyle,
                                      ),
                                      Text(
                                        'Tentang Kami',
                                        style: mServiceSubtitleStyle,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => CustomDialog(
                                      title: "Developed By",
                                      description: "Dzulumat",
                                    ));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //Layanan Unggulan
            Padding(
              padding: EdgeInsets.only(left: 16, top: 10),
              child: Text(
                'Layanan Unggulan',
                style: mTitleStyle,
              ),
            ),
            Container(
              height: 140,
              child: ListView.builder(
                itemCount: unggulan.length,
                padding: EdgeInsets.only(left: 16, right: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      height: 140,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: kPrimaryLightColor, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              unggulan[index].image,
                              height: 74,
                            ),
                            Text(
                              unggulan[index].name,
                              style: mServiceTitleStyle,
                            ),
                            Text(
                              unggulan[index].layanan,
                              style: mServiceSubtitleStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         title: Text('Home'),
      //         backgroundColor: kPrimaryColor),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.lock_clock),
      //         title: Text('Jadwal'),
      //         backgroundColor: kPrimaryColor),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.bed),
      //         title: Text('Kamar'),
      //         backgroundColor: kPrimaryColor),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         title: Text('Akun'),
      //         backgroundColor: kPrimaryColor),
      //   ],
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      // )
    );
  }

  Widget buildNavigateButton() => FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        icon: Icon(Icons.local_hospital),
        label: Text('Daftar Online'),
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Pendaftaran();
              },
            ),
          );
        },
      );
}

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;
  CustomDialog({this.title, this.description, this.buttonText, this.image});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 100,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(17),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                )
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(description, style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Baiklah"),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Colors.teal[600],
            radius: 60,
            backgroundImage: AssetImage('assets/images/anim.gif'),
          ),
        )
      ],
    );
  }
}
