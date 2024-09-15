import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/article.dart';

abstract class ArticleRemoteState extends Equatable {
  final List<ArticleEntity>? articles;
  final DioException? error;

  const ArticleRemoteState({this.articles, this.error});

  @override
  List<Object> get props => [articles!, error!];
}

class ArticlesRemoteLoading extends ArticleRemoteState {
  const ArticlesRemoteLoading();
}

class ArticlesRemoteDone extends ArticleRemoteState {
  const ArticlesRemoteDone(List<ArticleEntity> article)
      : super(articles: article);
}

class ArticlesRemoteFailed extends ArticleRemoteState {
  const ArticlesRemoteFailed(DioException error) : super(error: error);
}
