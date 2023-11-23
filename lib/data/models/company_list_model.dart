import 'package:flutter_core/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

import 'company_model.dart';

class CompanyListModel extends BasePaginatedListModel<CompanyModel>
    implements BaseNetworkDeserializable<CompanyListModel> {
  CompanyListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  CompanyListModel fromJson(dynamic json) {
    return CompanyListModel(
      dataList: json['dataList'] == null
          ? []
          : List<CompanyModel>.from(
          json["dataList"].map((x) => CompanyModel.fromJson(x))),
    );
  }
}
