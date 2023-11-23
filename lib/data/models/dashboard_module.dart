import 'package:c_supervisor/ui/enums/module_types.dart';

class DashboardModule {
  DashboardModule({
    this.id,
    this.slaname,
    this.imagePath,
  });

  MainModuleTypes get mainModule =>
      MainModuleTypes.getType(id ?? MainModuleTypes.visits.moduleId);

  TeamModuleTypes get teamModule =>
      TeamModuleTypes.getType(id ?? TeamModuleTypes.visits.moduleId);

  DashboardModule.fromJson(dynamic json) {
    id = json['id'];
    slaname = json['slaname'];
    imagePath = json['imagePath'];
  }
  int? id;
  String? slaname;
  String? imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['slaname'] = slaname;
    map['imagePath'] = imagePath;
    return map;
  }
}
