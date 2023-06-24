part of 'saved_article_bloc.dart';

@immutable
abstract class SavedArticleState {}

abstract class SavedArticleActionState extends SavedArticleState {}

class SavedArticleInitial extends SavedArticleState {}

class ArticlesFetchingSuccessfulState extends SavedArticleState {
  final List<Storage>? articles;
  ArticlesFetchingSuccessfulState({required this.articles});
}
