import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Poli {
  final String medunitCd;
  final String medunitNm;

  Poli({
    this.medunitCd,
    this.medunitNm,
  });

  Poli.fromJson(Map<String, dynamic> json)
      : medunitCd = json['medunit_cd'],
        medunitNm = json['medunit_nm'];

  Map<String, dynamic> toJson() => {
        'medunit_cd': this.medunitCd,
        'medunit_nm': this.medunitNm,
      };
}

class PoliApi {
  static Future<List<Poli>> getPoliSuggestions(String query) async {
    final url = Uri.parse(
        'http://36.67.10.15:1317/bridging_pendaftaranonline/KlinikBuka.php');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final poli = await compute(jsonDecode, response.body);
      final data = poli['data'] as List;

      return data.map((i) => Poli.fromJson(i)).where((listpoli) {
        final nameLower = listpoli.medunitNm.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
