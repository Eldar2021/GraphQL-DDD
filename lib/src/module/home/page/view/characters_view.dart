import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../src.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView>
    with PaginationMixin<Character>, AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    pagingController.addPageRequestListener(fetchPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('CharactersView'),
      ),
      body: PagedListView<int, Character>(
        key: const Key('CharactersView'),
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<Character>(
          itemBuilder: (context, item, index) => Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  item.image ?? 'https://picsum.photos/200/300',
                ),
              ),
              title: Text(item.name),
              subtitle: Text(item.species ?? ''),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<List<Character>> fetchData(int page) {
    return context.read<HomeCubit>().getCharactersInPage(page);
  }

  @override
  bool get wantKeepAlive => true;
}
