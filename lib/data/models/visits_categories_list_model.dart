import 'package:c_supervisor/data/models/visits_categories_model.dart';
import 'package:flutter_core/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

class VisitsCategoriesListModel
    extends BasePaginatedListModel<VisitsCategoriesModel>
    implements BaseNetworkDeserializable<VisitsCategoriesListModel> {
  VisitsCategoriesListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  VisitsCategoriesListModel fromJson(dynamic json) {
    return VisitsCategoriesListModel(
      dataList: json['dataList'] == null
          ? []
          : List<VisitsCategoriesModel>.from(
          json["dataList"].map((x) => VisitsCategoriesModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
