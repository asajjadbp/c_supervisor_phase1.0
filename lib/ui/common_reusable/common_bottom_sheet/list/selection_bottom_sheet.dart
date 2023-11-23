import 'package:c_supervisor/data/models/common_data_model.dart';
import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/styles/colors.dart';
import 'package:c_supervisor/styles/theme.dart';
import 'package:c_supervisor/ui/bloc/app_bloc_consumer.dart';
import 'package:c_supervisor/ui/common_reusable/common_bottom_sheet/cubits/selection_cubit.dart';
import 'package:c_supervisor/ui/common_reusable/common_bottom_sheet/list/selection_list_tile.dart';
import 'package:c_supervisor/ui/pages/team_attendance/cubit/action_types_cubit.dart';
import 'package:c_supervisor/ui/pages/team_attendance/cubit/insert_action_type_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:networking/client/networking_models/index.dart';

// TODO : make args to this sheet custom
class SelectionBottomSheet {
  static void showSelectionBottomSheet(
      {required BuildContext parentContext,
      required VoidCallback onSelectionConfirmed,
      bool? isAttend}) {
    /// loading sort list based on [homeWidgetType] && [bookListType]
    // parentContext.read<K>().loadSortList(
    //   homeWidgetType: homeWidgetType,
    //   bookListType: bookListType,
    // );

    parentContext
        .read<ActionTypesCubit>()
        .fetchActionTypeList(isAttend: isAttend ?? false);

    final theme = Theme.of(parentContext);

    showModalBottomSheet(
      context: parentContext,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      builder: (dialogContext) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<ActionTypesCubit>.value(
                value: BlocProvider.of<ActionTypesCubit>(parentContext)),
            BlocProvider<InsertActionTypeCubit>.value(
                value: BlocProvider.of<InsertActionTypeCubit>(parentContext)),
            BlocProvider<SelectionCubit>.value(
              value: BlocProvider.of<SelectionCubit>(parentContext),
            )
          ],
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Action List',
                  style: TextStyle(
                      color: blue, fontWeight: FontWeight.w400, fontSize: 20),
                ),
              ),
              Expanded(
                child: BaseBlocConsumer<ActionTypesCubit,
                    BaseResponse<CommonDataListModel?>>(
                  onSuccessBuilder: (ctx, state) {
                    final List<CommonDataModel> selectionList =
                        state.value?.data?.dataList ?? [];
                    return ListView.separated(
                      separatorBuilder: (_, __) => Divider(
                        height: 3.h,
                        color: primaryColor,
                      ),
                      itemCount: selectionList.length,
                      itemBuilder: (context, index) {
                        return SelectionListTile(
                          commonDataModel: selectionList[index],
                        );
                      },
                    );
                  },
                  listenerCallBack: (context, state) {
                    // setDefaultItem(context, state)
                  },
                  isLoadingShown: true,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: AppBlocConsumer<InsertActionTypeCubit,
                      BaseResponse<EmptyModel?>>(
                    onSuccessBuilder: (context, state) {
                      final isLoading = state.status == RequestStatus.loading;

                      return LoadingButton(
                        text: 'Confirm',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                        borderRadius: 12,
                        btnColor: primaryColor,
                        btnHeight: 53.h,
                        btnWidth: 300.w,
                        colorScheme: colorScheme,
                        isLoading: isLoading,
                        isDisabled: false,
                        onPressed: () {
                          /// here u should have value for selection  and comment
                          onSelectionConfirmed.call();
                        },
                      );
                    },
                    isConsumerAction: true,
                  ))
            ],
          ),
        );
      },
    );
  }

// static void setDefaultItem(BuildContext context, BaseResponse<List<SortEntity>?>? state) {
//   final sortSelectionCubit = context.read<SortSelectionCubit>();
//   if(sortSelectionCubit.state == null) {
//     sortSelectionCubit.changeSortItemSelection(state?.data?.first);
//   }
// }
}
