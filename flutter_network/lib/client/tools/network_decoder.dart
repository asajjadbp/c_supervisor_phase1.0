import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:networking/client/networking_models/base_network_models/base_network_deserializable.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';
import 'package:networking/utilities/constants.dart';

class NetworkDecoder {
  static NetworkDecoder shared = NetworkDecoder();

  BaseResponse<K?> decode<T extends BaseNetworkDeserializable, K>({
    required Response<dynamic> response,
    required T responseType,
  }) {
    try {
      final data = response.data as Map<String, dynamic>;

      if (data['data'] != null && data['data'] is List) {
        final List list = data['data'] as List;
        final K? dataList = List<T>.from(
          list
              .map(
                (item) => responseType.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
        ) as K?;
        return BaseResponse<K?>(
          code: data[NetworkConst.code] as int?,
          message: data[NetworkConst.messageKey] as String?,
          data: dataList,
        );
      } else {
        final K? wrapperObj =
            (data.containsKey('response') ? data['response'] : data['data']) !=
                    null
                ? responseType.fromJson((data.containsKey('response')
                    ? data['response']
                    : data['data']) as Map<String, dynamic>,) as K?
                : null;
        return BaseResponse<K?>(
          code: data[NetworkConst.code] as int?,
          message: data[NetworkConst.messageKey] as String?,
          data: wrapperObj,
        );
      }
    } catch (e, stackTrace) {
      log(
        'Decoding Error',
        name: 'NetworkError',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
