class VisitBeforeFixingModel {
  String? categoryname;
  String? photoPath;


  VisitBeforeFixingModel({

    this.categoryname,
    this.photoPath,

  });
  VisitBeforeFixingModel.fromJson(dynamic json) {

    categoryname = json["categoryname"];
    photoPath = json["photoPath"];


  }
}
