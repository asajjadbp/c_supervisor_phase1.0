import 'package:flutter_core/models/common/user_values_list.dart';

class FormFieldList {
  FormFieldList({
    this.clientUserRequestFormFieldId,
    this.formFieldId,
    this.userValuesList,
  });

  int? clientUserRequestFormFieldId;
  int? formFieldId;
  List<UserValuesList>? userValuesList;

  factory FormFieldList.fromJson(Map<String, dynamic> json) => FormFieldList(
    clientUserRequestFormFieldId: json["clientUserRequestFormFieldId"],
    formFieldId: json["formFieldId"],
    userValuesList: List<UserValuesList>.from(
        json["userValuesList"].map((x) => UserValuesList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "clientUserRequestFormFieldId": clientUserRequestFormFieldId ?? 0,
    "formFieldId": formFieldId,
    "userValuesList":
    List<dynamic>.from(userValuesList ?? [].map((x) => x.toJson())),
  };

  @override
  String toString() {
    return toJson().toString();
  }
}