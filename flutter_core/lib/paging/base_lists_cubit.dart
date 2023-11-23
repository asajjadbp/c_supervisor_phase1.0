import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/tools/base_consumer/base_custom_cubit.dart';

/// abstraction for loading data for lists (both paginated and non paginated lists)
///
/// @see [ListDataCubit] and [PagingDataCubit]
abstract class BaseListsCubit<T> extends CustomBaseCubit<T> {
  Future<dynamic> loadItemsAtPage(int page, {dynamic args});
}
