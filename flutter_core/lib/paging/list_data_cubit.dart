import 'package:flutter_core/flutter_core.dart';

/// Provides non paging data for paging Controller
///
/// Used with non paging models (where [data] is 'List<T>')
abstract class ListDataCubit<T> extends BaseListsCubit {
  /// Load data at page index
  ///
  @override
  Future<List<T>> loadItemsAtPage(int page, {dynamic args});
}
