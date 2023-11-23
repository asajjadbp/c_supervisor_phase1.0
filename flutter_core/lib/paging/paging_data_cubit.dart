import 'package:flutter_core/flutter_core.dart';

/// Provides data for paging controller
///
/// Used with paginated data models [BasePaginatedListModel]
/// Used with paginated data models when [BaseResponse.data] is child of [BasePaginatedListModel]
abstract class PagingDataCubit<T extends BasePaginatedListModel>
    extends BaseListsCubit<T> {
  /// Load data at page index
  ///
  @override
  Future<T> loadItemsAtPage(int page, {dynamic args});
}
