import 'dart:io';
import 'package:networking/client/networking_models/config_models/request_type.dart';
import 'package:networking/client/networking_models/network_delegates/index.dart';

/// Blueprint for request data
///
class RouteConfig {
  String? baseUrl;
  final String path;

  List<File>? files;

  String? filesArrayName;

  final RequestType requestType;
  Map<String, String> headers;

  final Map<String, dynamic> parameters;

  final Map<String, dynamic> body;

  final RequestProgressDelegate? requestProgressDelegate;
  final bool isTokenRequired;

  RouteConfig({
    this.baseUrl,
    required this.path,
    this.files,
    this.filesArrayName,
    required this.requestType,
    this.headers = const <String, String>{},
    this.body = const <String, dynamic>{},
    this.requestProgressDelegate,
    this.isTokenRequired = true,
    this.parameters = const {},
  });

  Uri get fullUrl => Uri.parse(
        '$baseUrl/$path',
      );

  RouteConfig copyWith({
    RequestType? requestType,
    String? baseUrl,
    String? path,
    List<File>? files,
    String? filesArrayName,
    Map<String, String>? headers,
    Map<String, dynamic>? parameters,
  }) =>
      RouteConfig(
        baseUrl: baseUrl ?? this.baseUrl,
        path: path ?? this.path,
        files: files ?? this.files,
        filesArrayName: filesArrayName ?? this.filesArrayName,
        requestType: requestType ?? this.requestType,
        headers: headers ?? this.headers,
        parameters: parameters ?? this.parameters,
      );
}
