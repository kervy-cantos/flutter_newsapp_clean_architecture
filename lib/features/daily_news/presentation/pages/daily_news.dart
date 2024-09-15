import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/article/remote/article_remote_bloc.dart';
import '../bloc/article/remote/article_remote_state.dart';
import '../widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text('Daily News', style: TextStyle(color: Colors.black)),
    );
  }

  _buildBody() {
    return BlocBuilder<ArticleRemoteBloc, ArticleRemoteState>(
        builder: (_, state) {
      if (state is ArticlesRemoteLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }
      if (state is ArticlesRemoteFailed) {
        return const Center(
          child: Icon(Icons.refresh),
        );
      }
      if (state is ArticlesRemoteDone) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return ArticleWidget(
              article: state.articles![index],
            );
          },
          itemCount: state.articles!.length,
        );
      }

      return const SizedBox();
    });
  }
}
