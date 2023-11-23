import 'package:c_supervisor/data/models/filter_model.dart';
import 'package:c_supervisor/ui/enums/filter_type.dart';
import 'package:flutter/cupertino.dart';

class FilterArgs {
  final Function(FilterModel filterModel, BuildContext context)
      teamSearchByFilter;

  FilterArgs(
      {required this.teamSearchByFilter,
      required this.parentBuildContext,
      required this.filterType});

  final BuildContext parentBuildContext;

 final FilterType filterType;
}
