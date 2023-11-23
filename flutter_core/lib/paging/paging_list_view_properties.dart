import 'package:flutter/material.dart';

class PagingListViewProperties {
  const PagingListViewProperties(
      {
      //Todo(bug): Localize this
      required this.retryTitle,
      required this.noItemsFound,
      required this.connectionError,
      required this.serverError});

  factory PagingListViewProperties.defaultProperties(
    BuildContext context, {
    String? retryTitle,
    required String noItemsFound,
    String? connectionError,
    String? serverError,
  }) =>
      PagingListViewProperties(
        retryTitle: retryTitle ?? '',
        noItemsFound: noItemsFound,
        connectionError: connectionError ?? '',
        serverError: serverError ?? '',
      );

  final String retryTitle;
  final String noItemsFound;
  final String connectionError;
  final String serverError;
}
