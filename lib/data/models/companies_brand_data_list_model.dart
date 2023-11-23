import 'package:c_supervisor/data/models/companies_brand_data_model.dart';
import 'package:flutter_core/models/index.dart';
import 'package:networking/client/networking_models/index.dart';


class CompaniesBrandDataListModel
    extends BasePaginatedListModel<CompaniesBrandDataModel>
    implements BaseNetworkDeserializable<CompaniesBrandDataListModel> {
  CompaniesBrandDataListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  CompaniesBrandDataListModel fromJson(dynamic json) {
    return CompaniesBrandDataListModel(
      dataList: json['dataList'] == null
          ? []
          : List<CompaniesBrandDataModel>.from(
              json["dataList"].map((x) => CompaniesBrandDataModel.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }
}
