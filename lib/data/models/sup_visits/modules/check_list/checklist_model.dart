class CheckListModel {
  int? checkItemID;
  String? checkItemName;
  bool? isRequired;
  int? itemResponseId;
  bool? checkedStatus;
  num? rate;
  String? comment;
  CheckListModel.fromJson(dynamic json) {
    checkItemID = json['checkItemID'];
    checkItemName = json['checkItemName'];
    isRequired = json['isRequired'];
    itemResponseId = json['itemResponseId'];
    checkedStatus = json['checkedStatus'];
    rate = json['rate'];
    comment = json['comment'];
  }
}
