import 'package:newsapp/Core/GlobalMethods.dart';
import 'package:reading_time/reading_time.dart';

class NewsModel {
  List<ArticlesModel>? articles;
  String? status;
  NewsModel({this.articles});
  NewsModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['articles'] != null) {
      articles = [];
      json['articles'].forEach((element) {
        articles!.add(ArticlesModel.fromjson(element));
      });
    }
  }
}

class ArticlesModel {
  SourceModel? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  String? dataToShow;
  String? readingTimeText;

  ArticlesModel(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content,
      this.dataToShow,
      this.readingTimeText});

  ArticlesModel.fromjson(Map<String, dynamic> json) {
    String title = json['title'] ?? 'null';
    String content = json['content'] ?? '';
    String description = json['description'] ?? '';
    String dataToShow = '';
    if (json['publishedAt'] != null) {
      dataToShow = GlobalMethods.formattedDate(json['publishedAt']);
    }
    source =
        json['source'] != null ? SourceModel.fromjson(json['source']) : null;
    author = json['author'] ?? '';
    this.title = title;
    this.description = description;
    this.content = content;
    this.dataToShow = dataToShow;

    url = json['url'] ?? '';
    urlToImage = json['urlToImage'] ??
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtdnviQh7zw3cPSUP-BlniN2eoS3H9dRHUuw&usqp=CAU';
    publishedAt = json['publishedAt'] ?? '';

    readingTimeText = readingTime(title + content + description).msg;
  }
}

class SourceModel {
  String? sourceId;
  String? sourceName;
  SourceModel({this.sourceId, this.sourceName});

  SourceModel.fromjson(Map<String, dynamic> json) {
    sourceId = json['id'] ?? '';
  }
}
