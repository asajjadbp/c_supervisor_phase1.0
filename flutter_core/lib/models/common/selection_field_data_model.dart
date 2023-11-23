import 'package:flutter_core/models/index.dart';

/// SelectionFieldDataModel class hold data for SelectionFormRow
class SelectionFieldDataModel with Identifiable {
  SelectionFieldDataModel({
    required this.index,
    required this.text,
  });

  final int index;
  final String text;

  @override
  int get value => index;

  @override
  String toString() => text;

  factory SelectionFieldDataModel.fromJson(Map<String, dynamic> json) =>
      SelectionFieldDataModel(
        index: json["value"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "text": text,
      };
}
