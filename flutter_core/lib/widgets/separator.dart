import 'package:flutter/material.dart';

/// This class is a collection of various already-defined
/// material widgets. In this case, the widgets have multiple
/// default parameters, which will help developers streamline their desings.
class Separator {
  /// Normal spacer. This widget can be combined with [RowItem] widgets.
  static spacer([double space = 12]) {
    return SizedBox(height: space, width: space);
  }

  /// Smaller spacer, ment be combined with [RowItem] widgets.
  static smallSpacer() {
    return const SizedBox(height: 8, width: 8);
  }

  /// Divider with height 0, as thin as a piece of paper.
  static divider({double indent = 0}) {
    return Divider(height: 0, indent: indent);
  }

  /// Empty widget, there's nothing more to say.
  static none() {
    return const SizedBox(
      width: 0,
      height: 0,
    );
  }
}
