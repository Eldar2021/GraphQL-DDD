import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

mixin PaginationMixin<T> {
  final pagingController = PagingController<int, T>(firstPageKey: 0);
  Future<List<T>> fetchData(int page);

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
}
