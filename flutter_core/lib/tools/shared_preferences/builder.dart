import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A widget based on shared preferences value
///
/// Example:
/// ```dart
///   SharedPreferencesBuilder<String?>(
///     preference: 'access_token',
///     builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
///       return snapshot.hasData ? Text(snapshot.data ?? '') : Container();
///     },
///   )
/// ```
class SharedPreferencesBuilder<T> extends StatelessWidget {
  const SharedPreferencesBuilder({
    Key? key,
    required this.preference,
    required this.builder,
  }) : super(key: key);

  /// SHared preference key
  final String preference;

  /// Widget Builder
  final AsyncWidgetBuilder<T?> builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T?>(
      future: _preferenceValueAsFuture(),
      builder: (BuildContext context, AsyncSnapshot<T?> snapshot) {
        return builder(context, snapshot);
      },
    );
  }

  /// Returns value of preference key as future
  Future<T?> _preferenceValueAsFuture() async {
    final instance = await SharedPreferences.getInstance();
    return instance.get(preference) as T?;
  }
}
