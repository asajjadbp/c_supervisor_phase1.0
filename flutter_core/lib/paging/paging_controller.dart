import 'package:flutter/cupertino.dart';
import 'package:flutter_core/paging/paging_list_view_properties.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart'
    as paging;

import '../flutter_core.dart';

/// Paging Controller Wrapper
///
/// [T] is the item
class PagingController<T> {
  static const pageSize = 20;
  static const firstPageKey = 1;
  final BaseListsCubit _dataCubit;
  final PagingListViewProperties _listViewProperties;
  final paging.PagingController<int, T> pagingController;
  final VoidCallback unAuthorizedNavigationBlock;
  dynamic args;

  /// List cubit that handles non paginating lists
  ///
  /// Used when [BaseResponse.data] directly carries a (List<T>)
  PagingController.listCubit({
    required ListDataCubit<T> dataProvider,
    required this.unAuthorizedNavigationBlock,
    this.args,
    required PagingListViewProperties listViewProperties,
  })  : _dataCubit = dataProvider,
        _listViewProperties = listViewProperties,
        pagingController = paging.PagingController(firstPageKey: firstPageKey) {
    pagingController.addPageRequestListener((pageKey) {
      loadItemsAtPage(pageKey);
    });
  }

  /// List cubit that handles non paginating lists
  ///
  /// Used when [BaseResponse.data] directly carries a (List<T>)
  PagingController({
    required BaseListsCubit dataProvider,
    required this.unAuthorizedNavigationBlock,
    this.args,
    required PagingListViewProperties listViewProperties,
  })  : _dataCubit = dataProvider,
        _listViewProperties = listViewProperties,
        pagingController = paging.PagingController(firstPageKey: firstPageKey) {
    pagingController.addPageRequestListener((pageKey) {
      loadItemsAtPage(pageKey);
    });
  }

  /// Paging List cubit that handles paginating lists
  ///
  /// Used when [BaseResponse.data] is [BasePaginatedListModel]
  PagingController.pagingCubit({
    required PagingDataCubit dataProvider,
    required this.unAuthorizedNavigationBlock,
    this.args,
    required PagingListViewProperties listViewProperties,
  })  : _dataCubit = dataProvider,
        _listViewProperties = listViewProperties,
        pagingController = paging.PagingController(firstPageKey: firstPageKey) {
    pagingController.addPageRequestListener((pageKey) {
      loadItemsAtPage(pageKey);
    });
  }

  /// Refresh
  void refresh() {
    pagingController.refresh();
  }

  void updateArg(dynamic args) {
    this.args = args;
    refresh();
  }

  /// Should be called at state dispose to cancel all subscriptions
  void dispose() {
    pagingController.dispose();
  }

  /// Optional error if exists
  String? get error {
    // Todo(bug): error is thrown here with the full exception not just the message
    final error = pagingController.error;
    if (error is LocalizedError) {
      return error.message;
    } else if (error is String) {
      return error;
    }

    return error.toString();
  }

  /// Request data loading at page
  Future<void> loadItemsAtPage(int page) async {
    try {
      final data = await _dataCubit.loadItemsAtPage(page, args: args);
      final list = getListItems(data);
      if (data != null) {
        _didLoadItemsAtPage(list, page);
      }
      if (_dataCubit.state.statusCode != 0) {
        _didReceiveErrorForPage(page, _dataCubit.state.statusCode ?? 1);
      }
    } catch (error) {
      final state = _dataCubit.state;
      /*     if (state.status == RequestStatus.error) {
        final error = NetworkingException(message: state.message);
        _didReceiveErrorForPage( page,
            response.code);
      } else*/
      if (state.status == RequestStatus.unAuthorized) {
        unAuthorizedNavigationBlock.call();
      }
    }
  }

  /// Request data loading at first page
  Future<void> loadItemsAtFirstPage() async {
    return loadItemsAtPage(firstPageKey);
  }

  /// Handle loaded items at page key
  void _didLoadItemsAtPage(List<T> newItems, int pageKey) {
    final isLastPage = newItems.length < pageSize;

    if (isLastPage) {
      pagingController.appendLastPage(newItems);
    } else {
      final nextPageKey = pageKey + 1;
      pagingController.appendPage(newItems, nextPageKey);
    }
  }

  ///todo : add exception code
  /// Handle received error while loading items at page key
  void _didReceiveErrorForPage(int page, int exceptionStStatusCode) {
    final String errorMessage = getErrorMessage('initial error ');

    pagingController.error = errorMessage;
  }

  String getErrorMessage(/*NetworkExceptionTypes? type,*/ String error) {
    const String errorMessage = 'initial error message ';
    /* switch (type) {
      case NetworkExceptionTypes.serverError:
        errorMessage = _listViewProperties.serverError;
        break;
      case NetworkExceptionTypes.connectionError:
        errorMessage = _listViewProperties.connectionError;
        break;
      default:
        errorMessage = error;
    }*/
    return errorMessage;
  }

  /// returns the list to be shown in the UI
  ///
  /// handles the Paging and non paging lists
  ///   because in the paging list the [BaseResponse.data] carries a [BasePaginatedListModel] which carries the 'List<T>'
  ///   where in the non paging the [BaseResponse.data] directly contains the 'List<T>'
  List<T> getListItems(dynamic response) {
    final List<T> list;
    final isPagingList = response is BasePaginatedListModel;

    isPagingList ? list = response.dataList as List<T> : list = response;

    return list;
  }
}
