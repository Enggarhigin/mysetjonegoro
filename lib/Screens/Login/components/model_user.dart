class User {
  final String noRm;
  final String noHp;

  User({
    this.noRm,
    this.noHp,
  });

  User.fromJson(Map<String, dynamic> json)
      : noRm = json['norm'],
        noHp = json['nohp'];

  Map<String, dynamic> toJson() => {
        'norm': this.noRm,
        'nohp': this.noHp,
      };
}
