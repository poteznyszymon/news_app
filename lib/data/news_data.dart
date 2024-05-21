import 'package:dio/dio.dart';
import 'package:news/models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsData {
  static Future<List<Article>> getNews() async {
    List<Article> articles = [];

    final dio = Dio();
    final respone = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=');
    final newsJson = respone.data['articles'] as List;

    articles = newsJson.map((e) => Article.fromJson(e)).toList();
    return articles;
  }

  static Future<void> goToUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
