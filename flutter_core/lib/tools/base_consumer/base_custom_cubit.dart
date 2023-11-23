
import 'package:flutter_bloc/flutter_bloc.dart';
import '/tools/request_builder/request_state.dart';

/// [CustomBaseCubit] class responsible for handling emitting [error,unauthorized] and loading  states from one place
abstract class CustomBaseCubit<T> extends Cubit<RequestState<T>> {
  CustomBaseCubit() : super(const RequestState.init());

  /// emits and returns the [apiCall] result
  ///
  /// emits loading, loaded, and errors
  ///
  ///  implementation will be in app
  networkCall(
    Future<T> Function() apiCall, {
    Function()? successCall,
  });


  // networkCall(
  //   Future<T> Function() apiCall, {
  //   Function()? successCall,
  // }) async {
  //   try {
  //     _emitLoading();
  //     final response = await apiCall.call();
  //     _emitLoaded(response);
  //     if (response.code == 0) {
  //       successCall?.call();
  //     }
  //     return response;
  //   } catch (error) {
  //     //TODO: Check this if it should be private
  //     checkForNetworkConnections(error);
  //     // Todo: return base response which encapsulates error
  //     return BaseResponse<T>(
  //         code: 1, message: error.toString()); // 012 7319 6467   1986
  //   }
  // }

  // Future<BaseResponse<List<T>>> listNetworkCall(
  //     Future<BaseResponse<List<T>>> Function() apiCall,
  //     ) async {
  //   return apiCall.call();
  // }

  // _emitLoaded(BaseResponse<T> response) {
  //   emit(RequestState.loaded(response.data, response.message));
  // }

  /// responsible for emitting  exception
  // checkForNetworkConnections(Object e) {
  //   /// if [exception]  is  [UnauthorizedException]  emmit unAuthorized
  //   if (e is Exception) {
  //     if (e is UnauthorizedException) {
  //       /// emit un authorized error
  //       _emitUnauthorizedException(e);
  //     } else {
  //       _emitError(e);
  //     }
  //   } else {
  //     final error = e as Error;
  //     log(
  //       e.toString(),
  //       name: 'Error in NetworkLayer',
  //       stackTrace: error.stackTrace,
  //     );
  //   }
  // }

  /***emitting section***/

  /// for show  loading
  emitLoading() {
    emit(const RequestState.loading());
  }

  /// TWO cased implementation will be in  app or will be here
  emitLoaded(T? data, String message) {
    emit(RequestState.loaded(data, message));
  }

  emitUnauthorizedException(Exception exception) {
    emit(RequestState.unAuthorized(exception.toString()));
  }

  emitError(String messageError, int statusCode) {
    /// emitting errors in case of exception is [NetworkingException]
    emit(RequestState.error(messageError, statusCode: statusCode));
  }
}
