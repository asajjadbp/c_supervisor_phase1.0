import 'package:c_supervisor/data/models/region_model.dart';
import 'package:c_supervisor/ui/pages/filter/filter_region/cubits/selection_region_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// [SearchRegionResultItemTile] observe [BaseSelectSearchItemCubit] check if user select search item or not
class SearchRegionResultItemTile<T extends SelectRegionItemCubit>
    extends StatelessWidget {
  const SearchRegionResultItemTile({
    super.key,
    required this.regionModel,
  });

  final RegionModel? regionModel;

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;

    return BlocBuilder<T, List<RegionModel?>?>(
      builder: (context, state) {
        return ListTile(
          title: Text(
            regionModel?.value ?? '',
            style: TextStyle(
              fontSize: 18.sp,
              color: (state?.contains(regionModel) ?? false)
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
