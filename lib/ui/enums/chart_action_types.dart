import 'dart:ui';

import 'package:c_supervisor/styles/colors.dart';

enum ChartActionTypes {
  l2(2),
  absent(4);

  const ChartActionTypes(this.id);

  final int id;

  static ChartActionTypes getType(int id) => values.firstWhere(
        (element) => element.id == id,
        orElse: () => ChartActionTypes.absent,
      );

  Color getChartActionColor() {
    switch (this) {
      case ChartActionTypes.l2:
        return l2Color;
      case ChartActionTypes.absent:
        return redColor;
    }
  }
}
