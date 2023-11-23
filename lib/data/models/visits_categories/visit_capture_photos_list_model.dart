import 'package:c_supervisor/data/models/visits_categories/visit_capture_photos_model.dart';
import 'package:flutter_core/models/common/base_paginated_list_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_network_deserializable.dart';

class VisitCapturePhotosListModel extends BasePaginatedListModel<VisitCapturePhotosModel>
    implements BaseNetworkDeserializable<VisitCapturePhotosListModel> {
  VisitCapturePhotosListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  VisitCapturePhotosListModel fromJson(dynamic json) {
    return VisitCapturePhotosListModel(
      dataList: json['dataList'] == null
          ? []
          : List<VisitCapturePhotosModel>.from(
              json["dataList"].map((x) => VisitCapturePhotosModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
