import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:up2date/models/storage.dart';
part 'saved_article_event.dart';
part 'saved_article_state.dart';

class SavedArticleBloc extends Bloc<SavedArticleEvent, SavedArticleState> {
  SavedArticleBloc() : super(SavedArticleInitial()) {
    on<ArticleFetchEvent>(articleFetchEvent);
  }
  final user = FirebaseAuth.instance.currentUser!;
  FutureOr<void> articleFetchEvent(
      ArticleFetchEvent event, Emitter<SavedArticleState> emit) async {
    String email = user.email!;
    await Hive.openBox<Storage>(email);
    List<Storage>? articles = [];
    Box<Storage> box = Hive.box<Storage>(user.email!);
    Iterable<dynamic> Keys = box.keys;
    var it = Keys.iterator;
    while (it.moveNext()) {
      print(it.current);
      articles.add(box.get(it.current)!);
    }
    print(articles);
    emit(ArticlesFetchingSuccessfulState(articles: articles));
  }
}
