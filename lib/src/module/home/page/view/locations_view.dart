import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../src.dart';

class LocationsView extends StatefulWidget {
  const LocationsView({super.key});

  @override
  State<LocationsView> createState() => _LocationsViewState();
}

class _LocationsViewState extends State<LocationsView>
    with PaginationMixin<Location>, AutomaticKeepAliveClientMixin {
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
        title: const Text('LocationsView'),
      ),
      body: PagedListView<int, Location>(
        key: const Key('LocationsView'),
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<Location>(
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
  Future<List<Location>> fetchData(int page) {
    return context.read<HomeCubit>().getLocationsInPage(page);
  }

  @override
  bool get wantKeepAlive => true;
}
