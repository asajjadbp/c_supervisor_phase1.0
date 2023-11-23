class PlanoGramModel {
  String? categoryName;
  String? planogramReason;
  String? model;
  String? actual;
  int ?id;
  bool ?planogramIdentical;
  int ?reasonId;
  PlanoGramModel({
    this.categoryName,
    this.planogramReason,
    this.model,
    this.actual,
    this.id,
    this.planogramIdentical,
    this.reasonId,
  });
  PlanoGramModel.fromJson(dynamic json) {
    categoryName = json['categoryname'];
    planogramReason = json['planogramReason'];
    model = json['model'];
    actual = json['actual'];
    id = json['id'];
    planogramIdentical = json['planogramIdentical'];
    reasonId = json['reasonId'];
  }
}
