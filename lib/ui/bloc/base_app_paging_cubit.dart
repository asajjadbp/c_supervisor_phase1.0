import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';
import 'package:networking/client/networking_models/index.dart';

/// [BaseAppPagingCubit] used in all paginated list network calls across the app
abstract class BaseAppPagingCubit<T extends BasePaginatedListModel>
    extends PagingDataCubit<T> {
  /// loadItemsAtPage Load data at page index implemented by app paginated cubits
  @override
  Future<T> loadItemsAtPage(int page, {args});

  @override
  Future<BaseResponse<T?>> networkCall(
    Future Function() apiCall, {
    Function()? successCall,
  }) async {
    try {
      emit(RequestState.loaded(state.value));
      final response = await apiCall.call() as BaseResponse<T?>;
      if (response.hasError) {
        emitError(response.message ?? '', response.code);
      } else {
        emit(
          RequestState.loaded(
            response.data,
            response.message ?? '',
            response.code,
          ),
        );
        successCall?.call();
      }
      return response;
    } catch (error) {
      //TODO: Check this if it should be private
      // Todo: return base response which encapsulates error
      return BaseResponse<T>(
        code: 1,
        message: error.toString(),
      );
    }
  }
}
