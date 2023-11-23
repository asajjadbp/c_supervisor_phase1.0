import 'package:flutter_core/flutter_core.dart';

import '../../models/identifiable.dart';
import 'selection_stream_builder_widget.dart';

/// Used to provide data to [SelectionStreamBuilderWidget].
/// Data can be provided through internet or static as per use case needs.
abstract class SelectionDataProvider<T extends Identifiable> {
  /// Fetch data.
  ///
  /// Note: Element should implement [Object.toString()]
  /// as it's used to display a readable value to the user.
  Future<List<T>> fetchData({Object? args});
}
