import 'package:flutter_core/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

import 'companies_sku_data_model.dart';

class CompaniesSkuDataListModel
    extends BasePaginatedListModel<CompaniesSkuDataModel>
    implements BaseNetworkDeserializable<CompaniesSkuDataListModel> {
  CompaniesSkuDataListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  CompaniesSkuDataListModel fromJson(dynamic json) {
    return CompaniesSkuDataListModel(
      dataList: json['dataList'] == null
          ? []
          : List<CompaniesSkuDataModel>.from(json["dataList"]
              .map((x) => CompaniesSkuDataModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
