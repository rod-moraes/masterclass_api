import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterclass_api/app/home/domain/usecases/anime_usecase.dart';
import 'package:masterclass_api/app/home/external/datasource/anime_datasource.dart';
import 'package:masterclass_api/app/home/infra/repository/anime_repository.dart';
import 'package:masterclass_api/app/home/presenter/bloc/animes_bloc.dart';
import 'package:masterclass_api/app/home/presenter/bloc/animes_event.dart';
import 'package:masterclass_api/app/home/presenter/bloc/animes_state.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AnimesBloc bloc;
  late final ScrollController _scrollController;

  void _getMoreAnimes() {
    var nextPageTrigger = _scrollController.position.maxScrollExtent - 100;
    final state = bloc.state;
    if (_scrollController.position.pixels > nextPageTrigger &&
        state is AnimesStateSuccess) {
      final length = state.animes.length;
      final page = length ~/ 10;
      bloc.add(GetListAnimesEvent(page: page + 1, perPage: 10));
    }
  }

  @override
  void initState() {
    super.initState();
    final Dio dio = Dio();
    final AnimeDatasourceContract datasource = AnimeDatasource(dio: dio);
    final AnimeRepositoryContract repository =
        AnimeRepository(datasource: datasource);
    final GetListAnimesContract usecase = GetListAnimes(repository);
    bloc = AnimesBloc(usecase);
    bloc.add(const GetListAnimesEvent(page: 1, perPage: 10));
    _scrollController = ScrollController();
    _scrollController.addListener(_getMoreAnimes);
  }

  @override
  void dispose() {
    bloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Masterclass 5'),
      ),
      body: BlocBuilder<AnimesBloc, AnimesState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is AnimesStateError) {
              return Center(child: Text(state.message));
            }
            if (state is AnimesStateSuccess || state is AnimesStateLoading) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      controller: _scrollController,
                      itemCount: state.animes.length,
                      itemBuilder: (context, index) {
                        final itens = state.animes;
                        final item = itens.elementAt(index);

                        final title = item.title;
                        final description = item.description;
                        final date = item.date;
                        final link = item.link;

                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        title,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: theme.primaryColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${date.day}/${date.month}/${date.year}',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                    onPressed: () => launchUrlString(link),
                                    child: const Text(
                                      'Acessar matéria',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (state is AnimesStateLoading)
                    const Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ))
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
