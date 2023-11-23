import 'package:c_supervisor/data/models/company_model.dart';
import 'package:c_supervisor/ui/pages/filter/filter_company/cubits/selection_company_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// [SearchCompanyResultItemTile] observe [BaseSelectSearchItemCubit] check if user select search item or not
class SearchCompanyResultItemTile<T extends SelectCompanyItemCubit>
    extends StatelessWidget {
  const SearchCompanyResultItemTile({
    super.key,
    required this.companyModel,
  });

  final CompanyModel? companyModel;

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;

    return BlocBuilder<T, List<CompanyModel?>?>(
      builder: (context, state) {
        return ListTile(
          title: Text(
            companyModel?.value ?? '',
            style: TextStyle(
              fontSize: 18.sp,
              color: (state?.contains(companyModel) ?? false)
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
