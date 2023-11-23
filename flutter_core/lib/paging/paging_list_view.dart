import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart'
    as paging;

import 'index.dart';
import 'paging_list_view_properties.dart';

/// enum for configuring list view type
enum PagedListViewType {
  gridView,
  listView,
  sliverGrid,
}

typedef ItemWidgetBuilder<ItemType> = Widget Function(
  BuildContext context,
  ItemType item,
  int index,
);

class PagingListView extends StatefulWidget {
  const PagingListView({
    Key? key,
    required this.itemBuilder,
    this.firstPageProgressBuilder,
    this.padding = EdgeInsets.zero,
    required this.properties,
    required this.dataProvider,
    required this.unAuthorizedNavigatorBlock,
    this.args,
    this.scrollDirection = Axis.vertical,
    this.listType = PagedListViewType.listView,
    this.gridChildCrossAxisCount = 2,
    this.gridChildAspectRatio = 1.5,
    this.emptyPlaceholderWidget,
  }) : super(key: key);

  final ItemWidgetBuilder itemBuilder;
  final Widget Function(BuildContext)? firstPageProgressBuilder;
  final PagingListViewProperties properties;

  /// The list outer padding
  final EdgeInsetsGeometry? padding;
  final BaseListsCubit dataProvider;
  final VoidCallback unAuthorizedNavigatorBlock;

  /// [listType] to configure list type
  final PagedListViewType listType;

  /// [gridChildCrossAxisCount] configure row item  number
  final int gridChildCrossAxisCount;

  /// The aspect ratio of the single item
  ///
  /// width of item divided by height
  final double gridChildAspectRatio;

  final dynamic args;

  /// [scrollDirection] responsible for specify list scrolling direction
  final Axis scrollDirection;

  final Widget? emptyPlaceholderWidget;

  @override
  PagingListViewState createState() => PagingListViewState();
}

class PagingListViewState extends State<PagingListView> {
  late PagingController pagingController;
  late BaseListsCubit dataProvider;
  late Widget Function(BuildContext)? firstPageProgressBuilder;

  Widget get emptyPlaceHolder => widget.emptyPlaceholderWidget != null
      ? widget.emptyPlaceholderWidget!
      : SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: PagingFullscreenErrorIndicator(
            message: widget.properties.noItemsFound,
            onAction: refresh,
            retryTitle: widget.properties.retryTitle,
          ),
        );

  @override
  void initState() {
    dataProvider = widget.dataProvider;
    firstPageProgressBuilder = widget.firstPageProgressBuilder;
    initPagingController();
    super.initState();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.listType) {
      case PagedListViewType.listView:
        return RefreshIndicator(
          child: paging.PagedListView(
            scrollDirection: widget.scrollDirection,
            pagingController: pagingController.pagingController,
            padding: widget.padding,
            builderDelegate: paging.PagedChildBuilderDelegate(
              itemBuilder: widget.itemBuilder,
              firstPageProgressIndicatorBuilder: firstPageProgressBuilder ??
                  (context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: const Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
              firstPageErrorIndicatorBuilder: (ctx) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: PagingFullscreenErrorIndicator(
                    message: pagingController.error,
                    onAction: refresh,
                    retryTitle: widget.properties.retryTitle,
                  ),
                );
              },
              noItemsFoundIndicatorBuilder: (ctx) => emptyPlaceHolder,
              animateTransitions: true,
            ),
            // separatorBuilder: IndexedWidgetBuilder(),
          ),
          onRefresh: () => refresh(),
        );

      case PagedListViewType.gridView:
        return RefreshIndicator(
          child: paging.PagedGridView(
            scrollDirection: widget.scrollDirection,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.gridChildCrossAxisCount,
              childAspectRatio: widget.gridChildAspectRatio,
            ),
            pagingController: pagingController.pagingController,
            builderDelegate: paging.PagedChildBuilderDelegate(
              itemBuilder: widget.itemBuilder,
              firstPageProgressIndicatorBuilder: (context) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator()),
                );
              },
              firstPageErrorIndicatorBuilder: (ctx) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: PagingFullscreenErrorIndicator(
                    message: pagingController.error,
                    onAction: refresh,
                    retryTitle: widget.properties.retryTitle,
                  ),
                );
              },
              noItemsFoundIndicatorBuilder: (ctx) => emptyPlaceHolder,
              animateTransitions: true,
            ),
            // separatorBuilder: IndexedWidgetBuilder(),
          ),
          onRefresh: () => refresh(),
        );
      case PagedListViewType.sliverGrid:
        return paging.PagedSliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.gridChildCrossAxisCount,
            childAspectRatio: widget.gridChildAspectRatio,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
          ),
          pagingController: pagingController.pagingController,
          builderDelegate: paging.PagedChildBuilderDelegate(
            itemBuilder: widget.itemBuilder,
            firstPageProgressIndicatorBuilder: (context) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()),
              );
            },
            firstPageErrorIndicatorBuilder: (ctx) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: PagingFullscreenErrorIndicator(
                  message: pagingController.error,
                  onAction: refresh,
                  retryTitle: widget.properties.retryTitle,
                ),
              );
            },
            noItemsFoundIndicatorBuilder: (ctx) => emptyPlaceHolder,
            animateTransitions: true,
          ),
          // separatorBuilder: IndexedWidgetBuilder(),
        );
    }
  }

  void initPagingController() {
    if (dataProvider is PagingDataCubit) {
      pagingController = PagingController.pagingCubit(
        listViewProperties: widget.properties,
        dataProvider: dataProvider as PagingDataCubit,
        unAuthorizedNavigationBlock: widget.unAuthorizedNavigatorBlock,
        args: widget.args,
      );
    } else {
      pagingController = PagingController.listCubit(
        listViewProperties: widget.properties,
        dataProvider: dataProvider as ListDataCubit,
        unAuthorizedNavigationBlock: widget.unAuthorizedNavigatorBlock,
        args: widget.args,
      );
    }
  }

  Future<void> refresh() async {
    pagingController.refresh();
  }

  void updateDataProvider(BaseListsCubit provider) {
    dataProvider = provider;
    initPagingController();
  }
}
