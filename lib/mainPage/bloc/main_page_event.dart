part of 'main_page_bloc.dart';

@immutable
abstract class MainPageEvent {}

class NewsInitialFetchEvent extends MainPageEvent {
  final String Title;
  NewsInitialFetchEvent({
    required this.Title,
  });
}
