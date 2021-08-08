import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:rsud_setjo/const/const.dart';
import 'package:rsud_setjo/models/news.dart';
import 'package:http/http.dart' as http;

News parseNews(String responseBody) {
  var l = json.decode(responseBody);
  var news = News.fromJson(l);
  return news;
}

Future<News> fetchNewsByCategory(String category) async {
  final response = await http.get(Uri.parse(
      '$mainUrl$topHeadLines?language=en&category=$category&apiKey=$apiKey'));

  if (response.statusCode == 200)
    return compute(parseNews, response.body);
  else if (response.statusCode == 404)
    throw Exception('Not Found 404');
  else
    throw Exception('Cannot Get News');
}
