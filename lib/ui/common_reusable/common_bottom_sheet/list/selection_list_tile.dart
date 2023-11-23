import 'package:c_supervisor/data/models/common_data_model.dart';
import 'package:c_supervisor/styles/colors.dart';
import 'package:c_supervisor/ui/common_reusable/common_bottom_sheet/cubits/selection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/extensions/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectionListTile extends StatelessWidget {
  const SelectionListTile({
    super.key,
    required this.commonDataModel,
  });

  final CommonDataModel commonDataModel;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<CommonDataModel>(
      value: commonDataModel,
      groupValue: context.watch<SelectionCubit>().state,
      title: Text(
        commonDataModel.value ?? '',
        maxLines: 1,
        style: context.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeightExt.regular,
          fontSize: 18.sp,
        ),
      ),
      activeColor: primaryColor,
      onChanged: (value) =>
          context.read<SelectionCubit>().changeItemSelection(value!),
    );
  }
}
