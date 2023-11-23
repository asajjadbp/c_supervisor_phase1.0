import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/ui/pages/filter/cubit/selection_search_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// [SearchResultItemTile] observe [BaseSelectSearchItemCubit] check if user select search item or not
class SearchResultItemTile<T extends SelectSearchItemCubit>
    extends StatelessWidget {
  const SearchResultItemTile({
    super.key,
    required this.teamFilterResultModel,
  });

  final TeamFilterResultModel? teamFilterResultModel;

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;
    final style = TextStyle(
      fontSize: 18.sp,
      color: selectedColor,
      fontWeight: FontWeight.bold,
    );

    return BlocBuilder<T, List<TeamFilterResultModel?>?>(
      builder: (context, state) {
        return ListTile(
          title: Text(
            teamFilterResultModel?.name ?? '',
            style: TextStyle(
              fontSize: 18.sp,
              color: (state?.contains(teamFilterResultModel) ?? false)
                  ? selectedColor
                  : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
