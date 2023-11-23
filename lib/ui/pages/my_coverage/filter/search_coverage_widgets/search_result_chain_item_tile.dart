import 'package:c_supervisor/data/models/chain_model.dart';
import 'package:c_supervisor/ui/pages/my_coverage/cubits/selection_chain_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// [SearchChainResultItemTile] observe [BaseSelectSearchItemCubit] check if user select search item or not
class SearchChainResultItemTile<T extends SelectChainItemCubit>
    extends StatelessWidget {
  const SearchChainResultItemTile({
    super.key,
    required this.chainModel,
  });

  final ChainModel? chainModel;

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;

    return BlocBuilder<T, List<ChainModel?>?>(
      builder: (context, state) {
        return ListTile(
          title: Text(
            chainModel?.value ?? '',
            style: TextStyle(
              fontSize: 18.sp,
              color: (state?.contains(chainModel) ?? false)
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
