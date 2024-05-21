import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news/data/news_data.dart';
import 'package:news/screens/news_page/bloc/news_bloc.dart';

import '../../consts/consts.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    BlocProvider.of<NewsBloc>(context).add(NewsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Colors.black,
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case NewsFetchingLoadingState:
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            case NewsFetchingSuccesfulState:
              final sucessState = state as NewsFetchingSuccesfulState;
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<NewsBloc>(context)
                      .add(NewsInitialFetchEvent());
                },
                child: ListView.builder(
                  itemCount: sucessState.articles.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.white),
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            NewsData.goToUrl(Uri.parse(
                                sucessState.articles[index].url ?? ''));
                          },
                          title: Text(
                            sucessState.articles[index].title ?? "",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          leading: Image.network(
                            sucessState.articles[index].urlToImage ??
                                PLACEHOLDER_IMAGE_LINK,
                            height: 100,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                          subtitle: Text(
                            sucessState.articles[index].publishedAt ?? '',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    String formatedTime = DateFormat.MMMMEEEEd().format(now);
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Top News'),
          Text(formatedTime),
        ],
      ),
      backgroundColor: Colors.black,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
