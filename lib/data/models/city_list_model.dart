import 'package:c_supervisor/data/models/city_model.dart';
import 'package:flutter_core/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

class CitiesListModel extends BasePaginatedListModel<CityModel>
    implements BaseNetworkDeserializable<CitiesListModel> {
  CitiesListModel({
    super.dataList = const [],
    super.totalCount = 0,
  });

  @override
  CitiesListModel fromJson(dynamic json) {
    return CitiesListModel(
      dataList: json['dataList'] == null
          ? []
          : List<CityModel>.from(
          json["dataList"].map((x) => CityModel.fromJson(x))),
    );
  }
}
