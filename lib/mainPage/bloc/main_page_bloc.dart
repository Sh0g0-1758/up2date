import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:up2date/models/news_data.dart';
import 'package:http/http.dart' as http;

import '../../models/storage.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc() : super(MainPageInitial()) {
    on<NewsInitialFetchEvent>(newsInitialFetchEvent);
  }

  FutureOr<void> newsInitialFetchEvent(
      NewsInitialFetchEvent event, Emitter<MainPageState> emit) async {
    final user = FirebaseAuth.instance.currentUser!;
    String email = user.email!;
    await Hive.openBox<Storage>(email);
    List<Article>? newsContent = [];
    List<Article>? HeadNewsContent = [];
    String infoAboutWhichPageWeAreAt = event.Title;
    String custom = "technology";
    if (infoAboutWhichPageWeAreAt == "Home") {
      custom = "technology";
    } else if (infoAboutWhichPageWeAreAt == "Software Development") {
      custom = "software development";
    } else if (infoAboutWhichPageWeAreAt == "Cyb3r_S3cur1ty") {
      custom = "cyber security";
    } else if (infoAboutWhichPageWeAreAt == "Finance") {
      custom = "finance";
    } else if (infoAboutWhichPageWeAreAt == "Blockchain") {
      custom = "blockchain";
    } else if (infoAboutWhichPageWeAreAt == "AI/ML/NLP") {
      custom = "artificial intelligence";
    } else if (infoAboutWhichPageWeAreAt == "Quantum Computing") {
      custom = "quantum computing";
    } else if (infoAboutWhichPageWeAreAt == "Hackathons") {
      custom = "hackathons";
    } else if (infoAboutWhichPageWeAreAt == "CTFs") {
      custom = "hacking";
    }
    try {
      var Response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=$custom&apiKey=ba130b65aeb5412f8ae7c0714a498535'));
      Map<String, dynamic> result = jsonDecode(Response.body);
      Newsdata news = Newsdata.fromJson(result);
      newsContent = news.articles;
      print(newsContent);

      var HeadlineResponse = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?q=$custom&apiKey=ba130b65aeb5412f8ae7c0714a498535'));
      Map<String, dynamic> Headresult = jsonDecode(HeadlineResponse.body);
      Newsdata HeadNews = Newsdata.fromJson(Headresult);
      HeadNewsContent = HeadNews.articles;

      emit(NewsFetchingSuccessfulState(
          news: newsContent, Headnews: HeadNewsContent));
    } catch (e) {
      print(e);
    }
  }
}
