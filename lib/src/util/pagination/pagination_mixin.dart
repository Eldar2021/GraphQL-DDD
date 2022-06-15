import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

mixin PaginationMixin<P, T extends StatefulWidget> on State<T> {
  final pagingController = PagingController<int, P>(firstPageKey: 0);
  Future<List<P>> fetchData(int page);

  @override
  void initState() {
    pagingController.addPageRequestListener(fetchPage);
    super.initState();
  }

  Future<void> fetchPage(int p) async {
    try {
      final newItems = await fetchData(p);
      final isLastPage = newItems.length < 20;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        pagingController.appendPage(newItems, p + 1);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  void dispose() {
    super.dispose();
    pagingController.dispose();
  }
}
