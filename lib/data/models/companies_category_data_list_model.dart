import 'package:flutter_core/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

import 'companies_category_data_model.dart';

class CompaniesCategoryDataListModel
    extends BasePaginatedListModel<CompaniesCategoryDataModel>
    implements BaseNetworkDeserializable<CompaniesCategoryDataListModel> {
  CompaniesCategoryDataListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  CompaniesCategoryDataListModel fromJson(dynamic json) {
    return CompaniesCategoryDataListModel(
      dataList: json['dataList'] == null
          ? []
          : List<CompaniesCategoryDataModel>.from(json["dataList"]
              .map((x) => CompaniesCategoryDataModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
