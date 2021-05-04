import 'dart:convert';

import 'package:flutter_news_app/models/news_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<NewsModel> news = [];

  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=gb&apiKey=024c09c20f90438f9a8c7078185d04a9";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          NewsModel newsModel = NewsModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          news.add(newsModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<NewsModel> news = [];

  Future<void> getNews(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=gb&category=$category&apiKey=024c09c20f90438f9a8c7078185d04a9";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          NewsModel newsModel = NewsModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          news.add(newsModel);
        }
      });
    }
  }
}
