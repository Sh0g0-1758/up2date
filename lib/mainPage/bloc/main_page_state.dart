part of 'main_page_bloc.dart';

@immutable
abstract class MainPageState {}

abstract class MainPageActionState extends MainPageState {}

class MainPageInitial extends MainPageState {}

class NewsFetchingSuccessfulState extends MainPageState {
  final List<Article>? news;
  final List<Article>? Headnews;
  NewsFetchingSuccessfulState({required this.news, required this.Headnews});
}
