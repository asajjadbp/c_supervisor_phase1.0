class MyCoverageModel {
  MyCoverageModel({
    this.storeId,
    this.storeLongitude,
    this.storeLatitude,
    this.storeName,
    this.cityName,
    this.noOfClients,
    this.photoPath,
    this.chainName,
    this.clients,
  });

  MyCoverageModel.fromJson(dynamic json) {
    storeId = json['storeId'];
    storeLongitude = json['storeLongitude'];
    storeLatitude = json['storeLatitude'];
    storeName = json['storeName'];
    cityName = json['cityName'];
    noOfClients = json['noOfClients'];
    photoPath = json['photoPath'];
    chainName = json['chainName'];
    if (json['clients'] != null) {
      clients = List<String>.from(json['clients'].map((x) => x.toString()));
    }
  }

  int? storeId;
  num? storeLongitude;
  num? storeLatitude;
  String? storeName;
  String? cityName;
  int? noOfClients;
  String? photoPath;
  String? chainName;
  List<String>? clients;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['storeId'] = storeId;
    map['storeLongitude'] = storeLongitude;
    map['storeLatitude'] = storeLatitude;
    map['storeName'] = storeName;
    map['cityName'] = cityName;
    map['noOfClients'] = noOfClients;
    map['photoPath'] = photoPath;
    map['chainName'] = chainName;
    map['clients'] = clients;
    return map;
  }
}
