import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../src.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

// ignore: lines_longer_than_80_chars
class _CharactersViewState extends State<CharactersView> with PaginationMixin<Character> {
  @override
  void initState() {
    pagingController.addPageRequestListener(fetchPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              leading: Text(item.id),
              title: Text(item.name),
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
}
