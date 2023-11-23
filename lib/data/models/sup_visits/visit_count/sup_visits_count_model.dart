class SupVisitsCountModel {
  SupVisitsCountModel({
    this.pending,
    this.inProgress,
    this.finished,
  });

  SupVisitsCountModel.fromJson(dynamic json) {
    pending = json['pending'];
    inProgress = json['inProgress'];
    finished = json['finished'];
  }

  int? pending;
  int? inProgress;
  int? finished;
}
