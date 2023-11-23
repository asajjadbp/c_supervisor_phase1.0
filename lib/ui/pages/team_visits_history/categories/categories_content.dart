import 'package:c_supervisor/data/models/team_visits_history_model.dart';
import 'package:c_supervisor/ui/index.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../data/models/empty_model.dart';
import '../../../../data/models/rate/rate_model.dart';
import '../../../../domain/use_cases/add_rate_uc.dart';
import '../../../bloc/app_bloc_consumer.dart';
import 'cubits/rate_cubit.dart';
import 'index.dart';

final GlobalKey<PagingListViewState> categoriesPagingListViewKey =
    GlobalKey<PagingListViewState>();

class CategoriesContent extends StatelessWidget {
  CategoriesContent({
    Key? key,
    required this.moduleName,
    required this.teamVisitsHistoryModel,
  }) : super(key: key);
  final String moduleName;
  final TeamVisitsHistoryModel teamVisitsHistoryModel;
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BrandReusable.withAnyHeader(
      isWidgetStacked: true,
      header: Align(
        child: AppHeader(
          prefixHeaderWidgets: [
            const BackIconButton(),
            SizedBox(width: 15.w),
            const DrawerIconButton(),
            SizedBox(width: 15.w),
          ],
          headerTitle: moduleName,
        ),
      ),
      child: Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: Column(
            children: [
              SizedBox(
                height: 140.h,
                width: 350.w,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0.w,
                              vertical: 8.h,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: CustomCachedNetworkImage(
                                imgUrl:
                                    "https://testapi.catalist-me.com/${teamVisitsHistoryModel.details?.photoPath}",
                                placeholderPath: '',
                                height: 100.h,
                                width: 100.w,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200.w,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          teamVisitsHistoryModel
                                                  .details?.storeName
                                                  .toString() ??
                                              "",
                                          style: TextStyle(fontSize: 16.sp),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          openAlertRate(context);
                                          // showDialog(
                                          //   context: context,
                                          //   builder: (context) {
                                          //     double selectedRating =
                                          //         teamVisitsHistoryModel
                                          //                 .details?.rate
                                          //                 ?.toDouble() ??
                                          //             0;
                                          //
                                          //     return AlertDialog(
                                          //       title: const Text(
                                          //           'Rate This Visit'),
                                          //       content: Column(
                                          //         mainAxisSize:
                                          //             MainAxisSize.min,
                                          //         children: [
                                          //           RatingBar.builder(
                                          //             initialRating:
                                          //                 selectedRating,
                                          //             // minRating:
                                          //             //     0, // Change this if needed.
                                          //             direction:
                                          //                 Axis.horizontal,
                                          //             allowHalfRating: true,
                                          //             itemCount: 5,
                                          //             itemBuilder:
                                          //                 (context, _) =>
                                          //                     const Icon(
                                          //               Icons.star,
                                          //               color: primaryColor,
                                          //             ),
                                          //             onRatingUpdate:
                                          //                 (double value) {
                                          //               selectedRating = value;
                                          //             },
                                          //           ),
                                          //           SizedBox(height: 16.h),
                                          //           ElevatedButton(
                                          //             onPressed: () {
                                          //               Navigator.pop(context);
                                          //             },
                                          //             child: const Text(
                                          //               'Submit',
                                          //               style: TextStyle(
                                          //                 color: white,
                                          //               ),
                                          //             ),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     );
                                          //   },
                                          // ).then((rating) {
                                          //   if (rating != null) {
                                          //     // Update the teamVisitsHistoryModel with the new rating.
                                          //     // teamVisitsHistoryModel.details?.rate = rating.toInt();
                                          //   }
                                          // });
                                        },
                                        child: CircleAvatar(
                                          radius: 22,
                                          backgroundColor: primaryColor,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.star_rounded,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  teamVisitsHistoryModel
                                                              .details?.rate ==
                                                          null
                                                      ? '0'
                                                      : '${teamVisitsHistoryModel.details?.rate}',
                                                  style: TextStyle(
                                                    color: white,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                //SizedBox(height: 7.h),
                                Text(
                                  teamVisitsHistoryModel.details?.companyName
                                          .toString() ??
                                      "",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Check In',
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: greyColor),
                                        ),
                                        SizedBox(height: 7.h),
                                        Text(
                                          teamVisitsHistoryModel
                                                  .details?.checkIn
                                                  .toString() ??
                                              "",
                                          style: TextStyle(
                                              fontSize: 14.sp, color: blue),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 12.0.w),
                                      child: Container(
                                        height: 35.h,
                                        width: 1.w,
                                        color: greyColor.withOpacity(0.8),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Check Out',
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: greyColor),
                                        ),
                                        SizedBox(height: 7.h),
                                        Text(
                                          teamVisitsHistoryModel
                                                  .details?.checkOut
                                                  .toString() ??
                                              "",
                                          style: TextStyle(
                                              fontSize: 14.sp, color: blue),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 12.0.w),
                                      child: Container(
                                        height: 35.h,
                                        width: 1.w,
                                        color: greyColor.withOpacity(0.8),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Wrk HRS',
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: greyColor),
                                        ),
                                        SizedBox(height: 7.h),
                                        Text(
                                          teamVisitsHistoryModel
                                                  .details?.workingHrs
                                                  .toString() ??
                                              "",
                                          style: TextStyle(
                                              fontSize: 14.sp, color: blue),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: CategoriesList(
                  teamVisitsHistoryModel: teamVisitsHistoryModel,
                ),
              ),
              SizedBox(height: 15.h)
            ],
          ),
        ),
      ),
    );
  }

  openAlertRate(BuildContext context) {
    double? rateValue;
    final int visitId = teamVisitsHistoryModel.details?.visitID ?? 0;
    final int userId =
        GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider<RateCubit>(
          create: (_) => RateCubit(rateUC: GetIt.I<RateUC>()),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0.r)),
            ),
            contentPadding: EdgeInsets.only(top: 10.0.h),
            content: SizedBox(
              width: 300.0.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RatingBar.builder(
                        initialRating:
                            teamVisitsHistoryModel.details?.rate?.toDouble() ??
                                0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0.w),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: primaryColor,
                        ),
                        onRatingUpdate: (rating) {
                          rateValue = rating;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0.h),
                  Divider(color: Colors.grey, height: 4.0.h),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0.w, right: 30.0.w),
                    child: TextField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        hintText: "Add Review",
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                    ),
                  ),
                  AppBlocConsumer<RateCubit, BaseResponse<EmptyModel?>>(
                    onSuccessBuilder: (context, state) {
                      final isLoading = state.status == RequestStatus.loading;
                      return isLoading
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                addRate(
                                  rateValue ??
                                      teamVisitsHistoryModel.details?.rate ??
                                      0.0,
                                  context,
                                  visitId,
                                  userId,
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: 20.0.h,
                                  bottom: 20.0.h,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(32.0.r),
                                      bottomRight: Radius.circular(32.0.r)),
                                ),
                                child: Text(
                                  "Rate Visit",
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 16.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                    },
                    isConsumerAction: true,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void addRate(
    double rateValue,
    BuildContext context,
    int visitId,
    int userId,
  ) {
    context
        .read<RateCubit>()
        .addRate(
          rateModel: RateModel(
            visitId: visitId,
            userId: userId,
            comment: commentController.text,
            rate: rateValue,
          ),
        )
        .then((value) {
      if (value.message == 'Added') {
        navigateAfterRequestRate(context);
      }
    });
  }

  /// using [Navigator.of(context).pop();] 2 times
  /// because close dialog
  /// and then close the current page
  /// navigate to previous page to refresh
  void navigateAfterRequestRate(BuildContext context) {
    /// close dialog
    Navigator.of(context).pop();

    /// close the current page
    Navigator.of(context).pop();

    /// refresh the previous page
    teamVisitsHistoryPagingListViewKey.currentState?.refresh();
  }
}
