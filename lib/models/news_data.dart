// To parse this JSON data, do
//
//     final Newsdata = NewsdataFromJson(jsonString);

import 'dart:convert';

Newsdata NewsdataFromJson(String str) => Newsdata.fromJson(json.decode(str));

String NewsdataToJson(Newsdata data) => json.encode(data.toJson());

class Newsdata {
    String? status;
    int? totalResults;
    List<Article>? articles;

    Newsdata({
        required this.status,
        required this.totalResults,
        required this.articles,
    });

    factory Newsdata.fromJson(Map<String, dynamic> json) => Newsdata(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles!.map((x) => x.toJson())),
    };
}

class Article {
    Source? source;
    String? author;
    String? title;
    String? description;
    String? url;
    String? urlToImage;
    DateTime? publishedAt;
    String? content;

    Article({
        required this.source,
        required this.author,
        required this.title,
        required this.description,
        required this.url,
        required this.urlToImage,
        required this.publishedAt,
        required this.content,
    });

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source?.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "source": source?.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt?.toIso8601String(),
        "content": content,
    };
}

class Source {
    String? name;

    Source({
        required this.name,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}