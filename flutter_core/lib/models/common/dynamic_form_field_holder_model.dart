import 'dart:convert';

import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/models/common/user_values_list.dart';

/// [DynamicFormFieldHolderModel] hold all Form fields that comes from server-side
DynamicFormFieldHolderModel dynamicFormFieldFromJson(String str) =>
    DynamicFormFieldHolderModel.fromJson(json.decode(str));

String dynamicFormFieldToJson(DynamicFormFieldHolderModel data) =>
    json.encode(data.toJson());

class DynamicFormFieldHolderModel {
  DynamicFormFieldHolderModel({
    this.clientUserRequestId,
    required this.requestFor,
    required this.requestForMobileNumber,
    required this.formFields,
  });

  int? clientUserRequestId;
  String requestFor;
  String requestForMobileNumber;
  List<FormFieldType> formFields;

  factory DynamicFormFieldHolderModel.fromJson(Map<String, dynamic> json) =>
      DynamicFormFieldHolderModel(
        clientUserRequestId: json["clientUserRequestId"] ?? 0,
        requestFor: json["requestForName"],
        requestForMobileNumber: json["requestForMobileNumber"],
        formFields: List<FormFieldType>.from(
            (json["formFields"] ?? []).map((x) => FormFieldType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "clientUserRequestId": clientUserRequestId ?? 0,
        "requestForName": requestFor,
        "requestForMobileNumber": requestForMobileNumber,
        "formFields": List<dynamic>.from(formFields.map((x) => x.toJson())),
      };
}

/// [FormFieldType] is model hold all properties that responsible for drawing FormField
class FormFieldType {
  FormFieldType(
      {required this.formFieldId,
      required this.formFieldTypeId,
      required this.formFieldName,
      required this.isRequired,
      this.regularExpression,
      this.validationMessage,
      this.formFieldValues,
      this.userValuesList,
      this.clientUserRequestFormFieldId});

  int formFieldId;
  int formFieldTypeId;
  String formFieldName;
  bool isRequired;
  int? clientUserRequestFormFieldId;
  List<FormFieldValue>? formFieldValues;
  List<UserValuesList>? userValuesList;
  String? regularExpression;
  String? validationMessage;

  factory FormFieldType.fromJson(Map<String, dynamic> json) => FormFieldType(
        clientUserRequestFormFieldId: json["clientUserRequestFormFieldId"] ?? 0,
        formFieldId: json["formFieldId"],
        formFieldTypeId: json["formFieldTypeId"],
        formFieldName: json["formFieldName"],
        isRequired: json["isRequired"],
        regularExpression: json["regularExpression"],
        validationMessage: json["validationMessage"],
        // Todo(bug): remove the ?? [] below and the loading goes on forever
        formFieldValues: List<FormFieldValue>.from(
          (json["formFieldValues"] ?? []).map(
            (x) => FormFieldValue.fromJson(x),
          ),
        ),
        userValuesList:
            _getUserValuesList(json, json["clientUserRequestFormFieldId"] ?? 0),
      );

  static List<UserValuesList>? _getUserValuesList(
      dynamic json, int clientUserRequestFormFieldId) {
    return clientUserRequestFormFieldId != 0
        ? List<UserValuesList>.from(
            json["userValuesList"].map((x) => UserValuesList.fromJson(x)))
        : null;
  }

  Map<String, dynamic> toJson() => {
        "formFieldId": formFieldId,
        "formFieldTypeId": formFieldTypeId,
        "formFieldName": formFieldName,
        "isRequired": isRequired,
        "clientUserRequestFormFieldId": clientUserRequestFormFieldId ?? 0,
        "formFieldValues":
            List<dynamic>.from(formFieldValues ?? [].map((x) => x.toJson())),
        "userValuesList":
            List<dynamic>.from(userValuesList ?? [].map((x) => x.toJson())),
        "regularExpression": regularExpression ?? "",
        "validationMessage": validationMessage ?? "",
      };
}

/// [FormFieldValue]  model hold the actual values that fill FormField
class FormFieldValue with Identifiable {
  FormFieldValue({
    this.formFieldValueId,
    this.fieldValue,
    this.formFieldValueTypeId,
  });

  int? formFieldValueId;
  String? fieldValue;
  int? formFieldValueTypeId;

  factory FormFieldValue.fromJson(Map<String, dynamic> json) => FormFieldValue(
        formFieldValueId: json["formFieldValueId"],
        fieldValue: json["value"],
        formFieldValueTypeId: json["formFieldValueTypeId"],
      );

  Map<String, dynamic> toJson() => {
        "formFieldValueId": formFieldValueId,
        "value": fieldValue,
        "formFieldValueTypeId": formFieldValueTypeId,
      };

  @override
  int get value => formFieldValueId ?? 0;

  @override
  String toString() => fieldValue ?? "";
}
