import 'package:c_supervisor/data/models/sup_visits/to_json/start_visit_to_json_model.dart';
import 'package:c_supervisor/ui/pages/my_jp/cubits/start_visit_cubit.dart';
import 'package:c_supervisor/ui/pages/my_jp/cubits/upload_image_cubit.dart';
import 'package:c_supervisor/ui/pages/my_jp/module/my_jp_dashboard/my_jp_dashboard_page.dart';
import 'package:c_supervisor/ui/pages/my_jp/widgets/jp_list.dart';
import 'package:c_supervisor/ui/pages/team_kpi/index.dart';
import 'package:c_supervisor/utilities/mixins/location_methods.dart';
import 'package:c_supervisor/utilities/mixins/url_lanucher_mixin.dart';
import 'package:c_supervisor/utilities/mixins/user_info_mixin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../data/models/sup_visits/sup_visits_model.dart';
import '../../../../utilities/mixins/image_name_creation_mixin.dart';
import '../../../index.dart';
import 'jp_status.dart';

class JPCard extends StatefulWidget {
  const JPCard({
    super.key,
    required this.index,
    required this.supVisitsModel,
  });
  final int index;
  final SupVisitsModel supVisitsModel;

  @override
  State<JPCard> createState() => _JPCardState();
}

class _JPCardState extends State<JPCard>
    with ImageNameCreatorMixin, UserInfoMixin, UrlLauncherMixin {
  bool isLoading = false;
  String? photoPath;
  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      elevation: 4,
      child: Container(
        width: 343.w,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0.w,
                    vertical: 5.h,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: CustomCachedNetworkImage(
                      imgUrl:
                          "https://testapi.catalist-me.com/${widget.supVisitsModel.photoPath}",
                      placeholderPath: '',
                      width: 100.w,
                      height: 120.h,
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Padding(
                  padding: EdgeInsets.only(top: 5.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 170.w,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          widget.supVisitsModel.storeName ?? '',
                          style: TextStyle(
                            color: blue,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 7.h),
                      SizedBox(
                        width: 170.w,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          "TMR : ${widget.supVisitsModel.tmrFullName}",
                          style: TextStyle(
                            color: blue,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 7.h),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        "City : ${widget.supVisitsModel.cityName}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(height: 7.h),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        "Visit ID : ${widget.supVisitsModel.visitID}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(height: 7.h),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        "Visit Date : ${widget.supVisitsModel.visitDate}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(height: 7.h),
                      GestureDetector(
                        onTap: () => callLauncher(
                          widget.supVisitsModel.tmrTelephone ?? "",
                        ),
                        child: Card(
                          elevation: 0,
                          color: Colors.grey.withOpacity(0.5),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.call,
                                  color: white,
                                ),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  "Call TMR ",
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // PullDownButton(
                //   itemBuilder: (context) => [
                //     PullDownMenuItem(
                //       title: "TMR : ${widget.supVisitsModel.tmrFullName ?? ""}",
                //       onTap: () {},
                //       //  icon: Icons.person,
                //     ),
                //     PullDownMenuItem(
                //       onTap: () {},
                //       title:
                //           "Super Visor : ${widget.supVisitsModel.fullName ?? ""}",
                //     ),
                //     PullDownMenuItem(
                //       iconColor: primaryColor,
                //       title:
                //           "Call Tmr : ${widget.supVisitsModel.tmrTelephone ?? ''}",
                //       icon: Icons.call,
                //       onTap: () => callLauncher(
                //         widget.supVisitsModel.tmrTelephone ?? "",
                //       ),
                //     ),
                //   ],
                //   buttonBuilder: (context, showMenu) => CupertinoButton(
                //     onPressed: showMenu,
                //     padding: EdgeInsets.zero,
                //     child: const Icon(CupertinoIcons.ellipsis_circle),
                //   ),
                // )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CustomCachedNetworkImage(
                    imgUrl:
                        "https://testapi.catalist-me.com/${widget.supVisitsModel.companylogo}",
                    placeholderPath: '',
                    width: 40.w,
                    height: 40.h,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    "${widget.supVisitsModel.companyName}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Padding(
                    padding: EdgeInsets.only(right: 15.0.w),
                    child: InkWell(
                      onTap: () => openMaps(
                        latitude: widget.supVisitsModel.storeLatitude ?? 0.0,
                        longitude: widget.supVisitsModel.storeLongitude ?? 0.0,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/subermarket_loction.svg',
                        height: 25.h,
                        width: 25.w,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: JPVisitStatus(supVisitsModel: widget.supVisitsModel),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50.h,
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (_) => MyJpDashBoardPage(
                  //               visitId: widget.supVisitsModel.visitID ?? 0,
                  //             )));
                  validateVisit(widget.supVisitsModel);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                    ),
                  ),
                  color: checkVisitStatusColor(widget.supVisitsModel),
                  //primaryColor,
                  child: Center(
                    child: checkVisitStatusText(widget.supVisitsModel),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validateVisit(SupVisitsModel model) {
    if (model.visitStatus == "In Progress") {
      goToJPDashBoard(model);
    } else if (model.visitStatus == "Pending") {
      startVisit(model);
    }
  }

  /// [startVisit] use it to capture photo with super visor and start visit
  /// first
  /// user take a photo with fun [_takePhoto]
  /// if user click "ok" button on dialog
  /// then upload photo with fun [_uploadPhotoImage]
  /// then fun [_uploadPhotoImage] return photo path
  /// then send toJson to api
  /// then use [refreshPage] to refresh page to change state
  final currentPosition = LocationManager.currentPosition;
  startVisit(SupVisitsModel model) async {
    if (currentPosition != null) {
      await _takePhoto();
    }
  }

  Future<void> _takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      bool isLoading = false;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text("Captured Photo"),
                content: isLoading
                    ? SizedBox(
                        height: 50.h,
                        child: const Center(child: CircularProgressIndicator()),
                      )
                    : Image.file(File(image
                        .path)), // Display the captured image or loading indicator.
                actions: <Widget>[
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog.
                    },
                  ),
                  TextButton(
                    onPressed: isLoading
                        ? null // Disable the button when loading
                        : () async {
                            setState(() {
                              isLoading = true; // Set loading state to true
                            });

                            // Upload the captured image.
                            await _uploadPhotoImage(
                              image: image,
                              model: widget.supVisitsModel,
                            );

                            Navigator.of(context).pop(); // Close the dialog.
                          },
                    child: isLoading ? const Text("Uploading...") : const Text("OK"),
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }

  Future<void> _uploadPhotoImage({
    required XFile image,
    required SupVisitsModel model,
  }) async {
    String finalImagePath = await createPhotoNameMyJP(
      visitId: model.visitID ?? 0,
      image,
      moduleName: "SupVisits",
    );
    isLoading = true;
    final result = await context.read<UploadImageJPCubit>().uploadImageJP(
      files: [File(finalImagePath)],
    );

    photoPath = result.data?.imagePathes?[0] ?? "";

    isLoading = false;

    if (!result.hasError) {
      startVisitRequest(model);
    }
  }

  void startVisitRequest(
    SupVisitsModel model,
  ) async {
    final result = await context
        .read<StartVisitCubit>()
        .startVisitJP(
          model: StartVisitToJsonModel(
            userId: getUserId(),
            visitID: model.visitID ?? 0,
            photoPath: photoPath ?? "",
            userLatitude: currentPosition?.latitude ?? 0,
            userLongitude: currentPosition?.longitude ?? 0,
          ),
        )
        .then((value) {
      checkToGoDashBoardAndRefresh(value);
    });
  }

  checkToGoDashBoardAndRefresh(BaseResponse<SuccessResponseModel?> value) {
    if (value.message == "Success") {
      showSuccessMss();
      goToDashBoard();
      refresh();
    }
  }

  void showSuccessMss() {
    "Visit Successfully Started"
        .showToast(backgroundColor: Colors.green, gravity: ToastGravity.CENTER);
  }

  void refresh() {
    supVisitsAgingListViewKey.currentState?.refresh();
    ModuleList(
      modules: const [],
      isMainModule: true,
    ).refreshIndicatorMainDashBoardKey.currentState?.show();
    /// refreshIndicatorMainDashBoardKey.currentState?.show();
  }

  void goToDashBoard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MyJpDashBoardPage(
          visitId: widget.supVisitsModel.visitID ?? 0,
        ),
      ),
    );
  }

  void goToJPDashBoard(SupVisitsModel model) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MyJpDashBoardPage(
          visitId: model.visitID ?? 0,
        ),
      ),
    );
  }

  Color checkVisitStatusColor(SupVisitsModel model) {
    if (model.visitStatus == "Finished") {
      return Colors.green;
    } else if (model.visitStatus == "In Progress") {
      return blue;
    } else {
      return red;
    }
  }

  Text checkVisitStatusText(SupVisitsModel model) {
    if (model.visitStatus == "Finished") {
      return Text(
        'Visit Completed',
        style: TextStyle(
          color: white,
          fontSize: 16.sp,
        ),
      );
    } else if (model.visitStatus == "In Progress") {
      return Text(
        'Continue',
        style: TextStyle(
          color: white,
          fontSize: 16.sp,
        ),
      );
    } else {
      return Text(
        'Start Visit',
        style: TextStyle(
          color: white,
          fontSize: 16.sp,
        ),
      );
    }
  }
}
