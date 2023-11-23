import 'package:flutter_core/utilities/constants/configuration_constants.dart';

class PagingModel {
  PagingModel({
    required this.pageNumber,
    this.pageSize = ConfigurationConstants.pageSize,
    required this.sortingDirection,
  });

  int pageNumber;
  final int pageSize;
  final int sortingDirection;

  Map<String, dynamic> toJson() => {
        'pageNumber': pageNumber,
        'pageSize': pageSize,
        'sortingDirection': sortingDirection,
      };
}
