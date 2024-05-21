import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news/data/news_data.dart';
import 'package:news/models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<NewsInitialFetchEvent>(newsInitialFetchEvent);
  }

  Future<void> newsInitialFetchEvent(
      NewsInitialFetchEvent event, Emitter<NewsState> emit) async {
    emit(NewsFetchingLoadingState());
    try {
      List<Article> articles = await NewsData.getNews();
      emit(NewsFetchingSuccesfulState(articles: articles));
    } catch (e) {
      emit(NewsFetchingErrorState());
    }
  }

}
