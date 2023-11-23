class UpdateCheckListToJsonModel {
  final int visitId;
  final List<CheckListItemToJson> jsonArray;

  UpdateCheckListToJsonModel({
    required this.visitId,
    required this.jsonArray,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> jsonArrayJson =
        jsonArray.map((item) => item.toJson()).toList();

    return {
      'VisitId': visitId,
      'JsonArray': jsonArrayJson,
    };
  }
}

///
class CheckListItemToJson {
  final String checkItemID;
  final String itemResponseId;
  final String checkedStatus;
  final String rate;
  final String comment;

  CheckListItemToJson({
    required this.checkItemID,
    required this.itemResponseId,
    required this.checkedStatus,
    required this.rate,
    required this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      'CheckItemID': checkItemID,
      'ItemResponseId': itemResponseId,
      'CheckedStatus': checkedStatus,
      'Rate': rate == "null" ? "0" : rate,
      'Comment': comment,
    };
  }
}
