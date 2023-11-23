import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:c_supervisor/ui/pages/team_kpi/index.dart';
import 'package:flutter/material.dart';
class FeedbackBottomSheet {
  static void showSelectionBottomSheet({
    required BuildContext parentContext,
    required VoidCallback onSelectionConfirmed,
    required TextEditingController commentFeedbackController,
    required TextEditingController feedbackController,
  }) {
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
            BlocProvider<FeedbackListCubit>.value(
                value: BlocProvider.of<FeedbackListCubit>(parentContext)),
            BlocProvider<InsertFeedbackCubit>.value(
                value: BlocProvider.of<InsertFeedbackCubit>(parentContext)),
            BlocProvider<SelectionCubit>.value(
              value: BlocProvider.of<SelectionCubit>(parentContext),
            )
          ],
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Feedback',
                  style: TextStyle(
                      color: blue, fontWeight: FontWeight.w400, fontSize: 20),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      InkWell(
                        child: CustomTextField.withDarkBorder(
                          labelText: 'Select Your Feedback',
                          isEnabled: false,
                          height: 53.h,
                          myController: feedbackController,
                          suffixIcon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: primaryColor,
                            size: 25,
                          ),
                        ),
                        onTap: () {
                          /// show feedback list feedbackController will send to bottom the other bottom sheet
                          SelectionFeedbackBottomSheet.showSelectionBottomSheet(
                            parentContext: parentContext,
                            onSelectionConfirmed: () {
                              if (parentContext.read<SelectionCubit>().state !=
                                  null) {
                                Navigator.pop(parentContext);
                                feedbackController.text = parentContext
                                        .read<SelectionCubit>()
                                        .state
                                        ?.value ??
                                    '';
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextField.withDarkBorder(
                        labelText: 'Your Feedback',
                        height: 53.h,
                        myController: commentFeedbackController,
                        maxLines: 6,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: AppBlocConsumer<InsertFeedbackCubit,
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
}
