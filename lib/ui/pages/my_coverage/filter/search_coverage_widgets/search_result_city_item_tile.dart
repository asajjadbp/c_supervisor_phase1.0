import 'package:c_supervisor/data/models/city_model.dart';
import 'package:c_supervisor/ui/pages/my_coverage/cubits/selection_city_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// [SearchCityResultItemTile] observe [BaseSelectSearchItemCubit] check if user select search item or not
class SearchCityResultItemTile<T extends SelectCityItemCubit>
    extends StatelessWidget {
  const SearchCityResultItemTile({
    super.key,
    required this.cityModel,
  });

  final CityModel? cityModel;

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;

    return BlocBuilder<T, List<CityModel?>?>(
      builder: (context, state) {
        return ListTile(
          title: Text(
            cityModel?.value ?? '',
            style: TextStyle(
              fontSize: 18.sp,
              color: (state?.contains(cityModel) ?? false)
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
