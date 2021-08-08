class MedicalUnit {
  final String medunitCd;
  final String medunitNm;
  final String pelayananKlinik;

  MedicalUnit({
    this.medunitCd,
    this.medunitNm,
    this.pelayananKlinik,
  });

  MedicalUnit.fromJson(Map<String, dynamic> json)
      : medunitCd = json['medunit_cd'],
        medunitNm = json['medunit_nm'],
        pelayananKlinik = json['pelayanan_klinik'];

  Map<String, dynamic> toJson() => {
        'medunit_cd': this.medunitCd,
        'medunit_nm': this.medunitNm,
        'pelayanan_klinik': this.pelayananKlinik,
      };
}
