import 'package:flutter/material.dart';

class Poli {
  String title;
  String image;
  String dokter;

  Poli({@required this.title, @required this.image, @required this.dokter});
}

List<Poli> poliList = [
  Poli(
      title: "Poli Anak",
      image: "assets/images/anak.png",
      dokter:
          "dr. Handayani M.Sc Sp.A, dr. Sir Panggung Tri Subekti M.Sc Sp.A, dr. Heru Wahyono Sp.A"),
  Poli(
      title: "Poli Anestesi",
      image: "assets/images/anestesi.png",
      dokter: "dr. Totok Kristiyono M.Kes Sp.An, dr. Ingga H Sp.An"),
  Poli(
      title: "Poli Bedah",
      image: "assets/images/bedah.png",
      dokter: "dr. M. Fikri Sp.B, dr. Tri Wahyudi Sp.B, dr. Suyitno Sp.B"),
  Poli(
      title: "Poli Penyakit Dalam 1",
      image: "assets/images/dalam.png",
      dokter:
          "dr. Suprapto Sp.PD, dr. Arlyn Yuanita M.Kes Sp.PD , dr. Widhi Prasidhasunu Sp.PD"),
  Poli(
      title: "Poli Penyakit Dalam 2",
      image: "assets/images/dalam.png",
      dokter:
          "dr. Suprapto Sp.PD, dr. Arlyn Yuanita M.Kes Sp.PD , dr. Widhi Prasidhasunu Sp.PD"),
  Poli(
      title: "Poli Gigi",
      image: "assets/images/gigi.png",
      dokter: "drg. Jaka Mulyana, drg. H. Purnama Hadi M.Kes"),
  Poli(
      title: "Poli Jantung",
      image: "assets/images/jantung.png",
      dokter: "dr. Yosman Fredy Suroto Sp.JP"),
  Poli(
      title: "Poli Kandungan",
      image: "assets/images/obgyn.png",
      dokter:
          "dr. H. AI Suratman Sp.OG, dr. Nirwan Darmawan Sp.OG, dr. Tejo Sujatmiko Sp.OG, dr. Mira Maulina Sp.OG"),
  Poli(
      title: "Poli Kulit & Kelamin",
      image: "assets/images/kulit.png",
      dokter: "dr. H. Aries Budiarso Sp.KK"),
  Poli(
      title: "Poli Mata",
      image: "assets/images/mata.png",
      dokter: "dr. Faisal Lutfi Sp.M"),
  Poli(
      title: "Poli Orthopedi",
      image: "assets/images/ortopedi.png",
      dokter: "dr. Hirman Ari Wibawa Sp.OT"),
  Poli(
      title: "Poli Paru",
      image: "assets/images/paru.png",
      dokter: "dr. Kenyorini, Sp.P"),
  Poli(
      title: "Poli Psikiatri",
      image: "assets/images/psikiatri.png",
      dokter: "dr. Twiena Fridayanie, Sp.KJ, dr. Seno Bayu Aji, Sp.KJ"),
  Poli(
      title: "Poli Psikologi",
      image: "assets/images/psiko.png",
      dokter: "Harista Adiati M.Psi, Rini Indriati S.Psi (Psikolog)"),
  Poli(
      title: "Poli Saraf",
      image: "assets/images/saraf.png",
      dokter: "dr. Isnawan Widiyanto Sp.S"),
  Poli(
      title: "Poli THT",
      image: "assets/images/tht.png",
      dokter:
          "dr. Bakti Setio G, Sp.THT.KL, dr. Rohmatullah Subekti Sp.THT.KL"),
  Poli(
      title: "Fisioterapi",
      image: "assets/images/fisio.png",
      dokter:
          "Bambang P.N, SMPh.RPT, Budi Prastiyani AMF, Dina Wiranti Amd.FT, Musyawarah S.ST.FT, Ukhtiarida Insani Amd.FT, Sri Suryaningtyas Amd.FT"),
];
