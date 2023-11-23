import 'package:c_supervisor/data/models/companies_data_model.dart';
import 'package:flutter_core/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

class CompaniesDataListModel
    extends BasePaginatedListModel<CompaniesDataModel>
    implements BaseNetworkDeserializable<CompaniesDataListModel> {
  CompaniesDataListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  CompaniesDataListModel fromJson(dynamic json) {
    return CompaniesDataListModel(
      dataList: json['dataList'] == null
          ? []
          : List<CompaniesDataModel>.from(
          json["dataList"].map((x) => CompaniesDataModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
