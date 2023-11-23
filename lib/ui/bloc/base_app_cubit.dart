
import 'package:flutter_core/tools/base_consumer/base_custom_cubit.dart';
import 'package:networking/client/networking_models/index.dart';
class BaseAppCubit<T> extends CustomBaseCubit<BaseResponse<T?>> {
  @override
  networkCall(Future Function() apiCall, {Function()? successCall}) async {
    try {
      emitLoading();
      final response = await apiCall.call() as BaseResponse<T?>;
      if (response.hasError) {
        emitError(response.message ?? "", response.code);
      } else {
        emitLoaded(response, response.message ?? "");
        successCall?.call();
      }
      return response;
    } catch (error) {
      //TODO: Check this if it should be private
      // Todo: return base response which encapsulates error
      return BaseResponse<T>(
          code: 1, message: error.toString()); // 012 7319 6467   1986
    }
  }
}
