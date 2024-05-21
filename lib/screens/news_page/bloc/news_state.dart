part of 'news_bloc.dart';

@immutable
sealed class NewsState {}

final class NewsActionState extends NewsState {}

class NewsInitial extends NewsState {}

class NewsFetchingLoadingState extends NewsState {}

class NewsFetchingErrorState extends NewsState {}

class NewsFetchingSuccesfulState extends NewsState {
  final List<Article> articles;
  NewsFetchingSuccesfulState({required this.articles});
}
