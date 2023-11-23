class UserValuesList {
  UserValuesList({
    this.clientUserRequestFormFieldValueId,
    required this.value,
  });

  int? clientUserRequestFormFieldValueId;
  String value;

  factory UserValuesList.fromJson(Map<String, dynamic> json) => UserValuesList(
    clientUserRequestFormFieldValueId:
    json["clientUserRequestFormFieldValueId"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "clientUserRequestFormFieldValueId":
    clientUserRequestFormFieldValueId ?? 0,
    "value": value,
  };

  @override
  String toString() {
    return toJson().toString();
  }
}

