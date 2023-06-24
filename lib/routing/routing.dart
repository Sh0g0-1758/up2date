import 'package:flutter/material.dart';
import 'package:up2date/article/article.dart';
import 'package:up2date/auth/auth.dart';
import 'package:up2date/mainPage/mainPage.dart';
import 'package:up2date/auth/forgot_password.dart';
import 'package:up2date/models/news_data.dart';
import 'package:up2date/models/storage.dart';

import '../saved_articles/savedArticles.dart';
import '../saved_articles/saved_article_page.dart';

class RouteGenerator {
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const AuthPage());
      case '/forgotPassword':
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case '/page':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => MainPage(Title: args));
        } else {
          return _errorRoute();
        }
      case '/article':
        if (args is Article) {
          return MaterialPageRoute(builder: (_) => ArticlePage(data: args));
        } else {
          return _errorRoute();
        }
      case '/SavedArticle':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => SavedArticlepage(Title: args));
        } else {
          return _errorRoute();
        }
      case '/SavedArticlePage':
        if (args is Storage) {
          return MaterialPageRoute(
              builder: (_) => SavedArticleContentPage(data: args));
        } else {
          return _errorRoute();
        }
      default:
        return _errorRoute();
    }
  }
}
