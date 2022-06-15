import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../src.dart';

class EpisodesView extends StatefulWidget {
  const EpisodesView({super.key});

  @override
  State<EpisodesView> createState() => _EpisodesViewState();
}

// ignore: lines_longer_than_80_chars
class _EpisodesViewState extends State<EpisodesView> with PaginationMixin<Episode, EpisodesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EpisodesView'),
      ),
      body: PagedListView<int, Episode>(
        key: const Key('EpisodesView'),
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<Episode>(
          itemBuilder: (context, item, index) => Card(
            child: ListTile(
              leading: Text(item.id),
              title: Text(item.name),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<List<Episode>> fetchData(int page) {
    return context.read<HomeCubit>().getEpisodeInPage(page);
  }
}
