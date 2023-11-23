import 'package:c_supervisor/ui/pages/team_visits_history/team_visits_history_result/cubits/audit_visit_action_cubit.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../data/models/rate/rate_model.dart';
import '../../../../../domain/use_cases/add_rate_uc.dart';

import '../../../team_kpi/index.dart';
import '../../categories/cubits/rate_cubit.dart';
import 'index.dart';

class TeamVisitsHistoryResultCard extends StatelessWidget {
  TeamVisitsHistoryResultCard({
    Key? key,
    required this.index,
    required this.teamVisitsHistoryModel,
  }) : super(key: key);

  final TeamVisitsHistoryModel teamVisitsHistoryModel;
  final int index;
  final TextEditingController commentController = TextEditingController();
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    commentController.text = teamVisitsHistoryModel.details?.rateComment ?? '';

    final theme = Theme.of(context);
    return SizedBox(
      ///height: 340.h,
      width: 350.w,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                white,
                white,
                white,
                white,
                white,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 2.0.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: CustomCachedNetworkImage(
                            imgUrl:
                                "https://testapi.catalist-me.com/${teamVisitsHistoryModel.details!.photoPath}",
                            placeholderPath: '',
                            height: 100.h,
                            width: 90.w,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 150.w,
                                child: Text(
                                  teamVisitsHistoryModel.details!.storeName
                                      .toString(),
                                  style: TextStyle(fontSize: 16.sp),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () => _openMaps(
                                  latitude: teamVisitsHistoryModel
                                          .details?.storeLatitude ??
                                      0,
                                  longitude: teamVisitsHistoryModel
                                          .details?.storeLongitude ??
                                      0,
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/subermarket_loction.svg',
                                      color: primaryColor,
                                    ),
                                    SizedBox(width: 5.w),
                                    SizedBox(
                                      child: Text(
                                        'Location',
                                        style: TextStyle(
                                          color: black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            teamVisitsHistoryModel.details!.companyName
                                .toString(),
                            style:
                                TextStyle(fontSize: 16.sp, color: primaryColor),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            teamVisitsHistoryModel.details!.visitDate
                                .toString(),
                            style: TextStyle(fontSize: 13.sp, color: blue),
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Check In',
                                      style: TextStyle(
                                          fontSize: 12.sp, color: greyColor),
                                    ),
                                    SizedBox(height: 7.h),
                                    Text(
                                      teamVisitsHistoryModel.details!.checkIn
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 14.sp, color: blue),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 12.0.w),
                                child: Container(
                                  height: 35.h,
                                  width: 1.w,
                                  color: greyColor.withOpacity(0.8),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Check Out',
                                      style: TextStyle(
                                          fontSize: 12.sp, color: greyColor),
                                    ),
                                    SizedBox(height: 7.h),
                                    Text(
                                      teamVisitsHistoryModel.details!.checkOut
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 14.sp, color: blue),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 12.0.w),
                                child: Container(
                                  height: 35.h,
                                  width: 1.w,
                                  color: greyColor.withOpacity(0.8),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Wrk HRS',
                                      style: TextStyle(
                                          fontSize: 12.sp, color: greyColor),
                                    ),
                                    SizedBox(height: 7.h),
                                    Text(
                                      teamVisitsHistoryModel.details!.workingHrs
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 14.sp, color: blue),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // moduleVisitsListView(teamVisitsHistoryModel),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: greyColor.withOpacity(0.2),
                      radius: 15,
                      child: const Icon(
                        Icons.person,
                        color: greyColor,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    SizedBox(
                      width: 200.w,
                      child: Text(
                        teamVisitsHistoryModel.details?.workerName.toString() ??
                            "",
                        style: TextStyle(fontSize: 14.sp, color: primaryColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: SizedBox(
                            width: double.minPositive,
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: teamVisitsHistoryModel
                                      .visitCompanySLA?.length ??
                                  0,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(teamVisitsHistoryModel
                                          .visitCompanySLA?[index]
                                          .componentName ??
                                      ''),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                    child: Row(
                      children: [
                        Text(
                          "SLA KPIS : ",
                          style: TextStyle(
                            color: blue,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${teamVisitsHistoryModel.visitCompanySLA?.length ?? 0}",
                          style: TextStyle(
                            color: black,
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                InkWell(
                  // onTap: () {
                  //   openAlertRate(context);
                  // },
                  child: Card(
                    color: white,
                    elevation: 0,
                    child: Row(
                      children: [
                        // const Text(
                        //   'Rate this visit ',
                        //   style: TextStyle(color: primaryColor),
                        // ),
                        // SizedBox(width: 2.w),

                        ///
                        RatingBar.builder(
                          ignoreGestures: true,
                          initialRating: teamVisitsHistoryModel.details?.rate
                                  ?.toDouble() ??
                              0,
                          // minRating: 1,

                          direction: Axis.horizontal,
                          allowHalfRating: true,

                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 0.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: primaryColor,
                          ),

                          itemSize: 20,
                          onRatingUpdate: (double value) {},
                        ),
                        Text(
                          teamVisitsHistoryModel.details?.rate == null
                              ? '0.0'
                              : '${teamVisitsHistoryModel.details?.rate}',
                        ),
                        const Spacer(),

                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 17.sp,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              teamVisitsHistoryModel.details?.visitStatus ?? "",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        )

                        ///
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                /// const Spacer(),
                AppBlocConsumer<AuditVisitActionCubit,
                    BaseResponse<SuccessResponseModel?>>(
                  onSuccessBuilder: (context, state) {
                    // final bool isLoading =
                    //     state.status == RequestStatus.loading;
                    return LoadingButton(
                      text: 'AUDIT',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                      isLoading: _isLoading.value,
                      borderRadius: 10.r,
                      btnColor: primaryColor,
                      btnHeight: 35.h,
                      btnWidth: 310.w,
                      colorScheme: colorScheme,
                      isDisabled: false,
                      onPressed: () {
                        /// TODO : replace this navigate
                        startAuditVisit(context);
                      },
                    );
                  },
                  isConsumerAction: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // SizedBox moduleVisitsListView(TeamVisitsHistoryModel teamVisitsHistoryModel) {
  //   return SizedBox(
  //     height: 50.h,
  //     child: ListView.separated(
  //       padding: const EdgeInsets.all(0),
  //       scrollDirection: Axis.horizontal,
  //       itemCount: teamVisitsHistoryModel.visitCompanySLA!.length,
  //       itemBuilder: (context, index) {
  //         return moduleVisitsListViewItem(index, teamVisitsHistoryModel);
  //       },
  //       separatorBuilder: (context, index) => SizedBox(
  //         width: 2.w,
  //       ),
  //     ),
  //   );
  // }
  //
  // Padding moduleVisitsListViewItem(
  //     int index, TeamVisitsHistoryModel teamVisitsHistoryModel) {
  //   return Padding(
  //     padding: const EdgeInsets.all(3.0),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: white,
  //         borderRadius: BorderRadius.circular(7.r),
  //       ),
  //       height: 40.h,
  //       //width: 130.w,
  //       child: Card(
  //         color: blue,
  //         elevation: 0,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(7.r),
  //         ),
  //         child: Center(
  //           child: Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 12.0.w),
  //             child: Text(
  //               teamVisitsHistoryModel.visitCompanySLA![index].componentName
  //                   .toString(),
  //               style: TextStyle(
  //                 fontSize: 14.sp,
  //                 color: white,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
        Navigator.of(context).pop();
        teamVisitsHistoryPagingListViewKey.currentState?.refresh();
      }
    });
  }

  void _openMaps({required num latitude, required num longitude}) async {
    final String url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    try {
      await launch(url);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> startAuditVisit(BuildContext context) async {
    _isLoading.value = true;

    final result = await context.read<AuditVisitActionCubit>().startAdtVisit(
          visitId: teamVisitsHistoryModel.details?.visitID ?? 0,
        );

    if (result.message == "Success") {
      _isLoading.value = false;

      showSuccessMessage();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CategoriesPage(
            moduleName: 'Categories',
            visitsID: teamVisitsHistoryModel.details?.visitID ?? 0,
            teamVisitsHistoryModel: teamVisitsHistoryModel,
          ),
        ),
      );
    }
    _isLoading.value = false;
  }

  void showSuccessMessage() {
    "Visit Started Successfully".showToast(
      backgroundColor: Colors.green,
      gravity: ToastGravity.CENTER,
    );
  }
}
