class VisitCapturePhotosModel {
  String? categoryname;
  String? photoPath;
  String? reason;


  VisitCapturePhotosModel({

    this.categoryname,
    this.photoPath,
    this.reason,

  });
  VisitCapturePhotosModel.fromJson(dynamic json) {

    categoryname = json["categoryname"];
    photoPath = json["photoPath"];
    reason = json["reason"];

  }
}
