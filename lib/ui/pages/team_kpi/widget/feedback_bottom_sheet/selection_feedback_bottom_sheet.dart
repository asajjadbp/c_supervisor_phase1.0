import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:c_supervisor/ui/pages/team_kpi/index.dart';

import '../../../../common_reusable/common_bottom_sheet/list/selection_list_tile.dart';


class SelectionFeedbackBottomSheet {
  static void showSelectionBottomSheet({
    required BuildContext parentContext,
    required VoidCallback onSelectionConfirmed,
  }) {
    parentContext.read<FeedbackListCubit>().fetchFeedbackList();

    final theme = Theme.of(parentContext);

    showModalBottomSheet(
      context: parentContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r), topRight: Radius.circular(15.r)),
      ),
      builder: (dialogContext) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<SelectionCubit>.value(
              value: BlocProvider.of<SelectionCubit>(parentContext),
            ),
            BlocProvider<FeedbackListCubit>.value(
                value: BlocProvider.of<FeedbackListCubit>(parentContext)),
          ],
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Choose Feedback',
                  style: TextStyle(
                      color: blue, fontWeight: FontWeight.w400, fontSize: 20),
                ),
              ),
              Expanded(
                child: BaseBlocConsumer<FeedbackListCubit,
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
                  child: LoadingButton(
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
                    isDisabled: false,
                    onPressed: () {
                      onSelectionConfirmed.call();
                    },
                  ))
            ],
          ),
        );
      },
    );
  }
}
