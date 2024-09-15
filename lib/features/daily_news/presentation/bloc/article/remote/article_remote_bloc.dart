import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../domain/usecases/get_article.dart';
import 'article_remote_events.dart';
import 'article_remote_state.dart';

class ArticleRemoteBloc extends Bloc<ArticleRemoteEvents, ArticleRemoteState> {
  final GetArticleUseCase _getArticleUseCase;

  ArticleRemoteBloc(this._getArticleUseCase)
      : super(const ArticlesRemoteLoading()) {
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(
      GetArticles event, Emitter<ArticleRemoteState> emit) async {
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(ArticlesRemoteDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(ArticlesRemoteFailed(dataState.error!));
    }
  }
}
