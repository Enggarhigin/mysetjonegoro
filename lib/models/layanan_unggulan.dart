class LayananUnggulanModel {
  String name;
  String layanan;
  String image;

  LayananUnggulanModel(this.name, this.layanan, this.image);
}

List<LayananUnggulanModel> unggulan = unggulanData
    .map((item) =>
        LayananUnggulanModel(item['name'], item['layanan'], item['image']))
    .toList();
var unggulanData = [
  {
    "name": "Poli Anak",
    "layanan": "Rawat Jalan",
    "image": "assets/images/anak.png"
  },
  {
    "name": "Poli Jantung",
    "layanan": "Rawat Jalan",
    "image": "assets/images/jantung.png"
  },
  {
    "name": "Poli Paru",
    "layanan": "Rawat Jalan",
    "image": "assets/images/paru.png"
  },
  {
    "name": "Poli Dalam",
    "layanan": "Rawat Jalan",
    "image": "assets/images/dalam.png"
  },
  {
    "name": "Poli Saraf",
    "layanan": "Rawat Jalan",
    "image": "assets/images/saraf.png"
  },
  {
    "name": "Poli Mata",
    "layanan": "Rawat Jalan",
    "image": "assets/images/mata.png"
  },
  {
    "name": "Poli Kandungan",
    "layanan": "Rawat Jalan",
    "image": "assets/images/obgyn.png"
  },
  {
    "name": "Poli Orthopedi",
    "layanan": "Rawat Jalan",
    "image": "assets/images/ortopedi.png"
  },
  {
    "name": "Poli Psikiatri",
    "layanan": "Rawat Jalan",
    "image": "assets/images/psikiatri.png"
  },
  {
    "name": "Poli Gigi",
    "layanan": "Rawat Jalan",
    "image": "assets/images/gigi.png"
  },
  {
    "name": "Poli THT",
    "layanan": "Rawat Jalan",
    "image": "assets/images/tht.png"
  },
  {
    "name": "Fisioterapi",
    "layanan": "Rawat Jalan",
    "image": "assets/images/fisio.png"
  },
  {
    "name": "Hemodialisa",
    "layanan": "Rawat Jalan",
    "image": "assets/images/hd.png"
  },
  {
    "name": "Laboratorium",
    "layanan": "Rawat Jalan",
    "image": "assets/images/laborat.png"
  },
  {
    "name": "Radiologi",
    "layanan": "Rawat Jalan",
    "image": "assets/images/radio.png"
  },
];
