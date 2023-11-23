import 'package:c_supervisor/data/models/update_category/update_sos_model.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/cubits/sos/update_sos_cubit.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/sos/sos_list.dart';

import '../../../../../../data/models/visits_categories/sos_model.dart';
import '../../../../../../domain/use_cases/update_category/update_category_uc.dart';
import '../../../../../../utilities/mixins/camera_initializer_helper.dart';
import '../../../../../../utilities/mixins/image_name_creation_mixin.dart';

import '../../../../../../utilities/mixins/location_methods.dart';
import '../../../../../common_reusable/image_view.dart';
import '../../../../../index.dart';
import '../../../../team_kpi/index.dart';
import '../../cubits/sos/update_images_cubit.dart';

class SOSCard extends StatefulWidget {
  const SOSCard({
    super.key,
    required this.sosModel,
    required this.visitId,
  });

  final SOSModel? sosModel;
  final int? visitId;

  @override
  State<SOSCard> createState() => _SOSCardState();
}

class _SOSCardState extends State<SOSCard>
    with ImageNameCreatorMixin, CameraInitializerMixin {
  final userId =
      GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0;

  final TextEditingController categoryController = TextEditingController();

  final TextEditingController shelfTotalController = TextEditingController();

  final TextEditingController measureUnitController = TextEditingController();
  File? _imageFile;

  bool isLoadingSTS = false;
  bool isLoadingSS = false;
  String? pathPhoto;
  @override
  void initState() {
    super.initState();
    getLocation(context);
  }

  getLocation(BuildContext context) async {
    await LocationManager.getCurrentPosition(context);
  }

  @override
  Widget build(BuildContext context) {
    categoryController.text = widget.sosModel?.shelfCategorySpace ?? '';
    shelfTotalController.text = widget.sosModel?.shelfTotalSpace ?? '';
    measureUnitController.text = widget.sosModel?.measureUnit ?? '';
    return SizedBox(
      width: 350.w,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider<UpdateImagesCubit>(
            create: (_) => UpdateImagesCubit(
                updateCategoryUC: GetIt.I<UpdateCategoryUC>()),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              ImageViewOnAlert(
                                isExpanded: true,

                                /// image of typeId=1
                                imagePath:
                                    widget.sosModel?.photos![0].photoPath ?? "",
                              ),
                              BlocProvider(
                                create: (_) => UpdateSOSCubit(
                                    updateCategoryUC:
                                        GetIt.I<UpdateCategoryUC>()),
                                child: AppBlocConsumer<UpdateSOSCubit,
                                    BaseResponse<EmptyModel?>>(
                                  onSuccessBuilder: (context, state) {
                                    return isLoadingSTS
                                        ? SizedBox(
                                            height: 20.h,
                                            width: 20.w,
                                            child:
                                                const CircularProgressIndicator(),
                                          )
                                        : LoadingButton(
                                            onPressed: () async {
                                              await _takePhoto(1);
                                              if (_imageFile != null) {
                                                update(
                                                  context: context,
                                                  isDelete: false,
                                                  isPopContext: false,
                                                  indexImage: 1,
                                                );
                                              }
                                            },
                                            text: 'Edit',
                                            btnWidth: 50.w,
                                            btnHeight: 25.h,
                                          );
                                  },
                                  isConsumerAction: true,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Text(widget.sosModel?.photos?[0].typeName ?? '')
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              ImageViewOnAlert(
                                isExpanded: true,

                                /// image of typeId=2
                                imagePath:
                                    widget.sosModel?.photos?[1].photoPath ?? "",
                              ),
                              BlocProvider(
                                create: (_) => UpdateSOSCubit(
                                    updateCategoryUC:
                                        GetIt.I<UpdateCategoryUC>()),
                                child: AppBlocConsumer<UpdateSOSCubit,
                                    BaseResponse<EmptyModel?>>(
                                  onSuccessBuilder: (context, state) {
                                    return isLoadingSS
                                        ? SizedBox(
                                            height: 20.h,
                                            width: 20.w,
                                            child:
                                                const CircularProgressIndicator(),
                                          )
                                        : LoadingButton(
                                            onPressed: () async {
                                              await _takePhoto(2);
                                              if (_imageFile != null) {
                                                update(
                                                  context: context,
                                                  isDelete: false,
                                                  isPopContext: false,
                                                  indexImage: 2,
                                                );
                                              }
                                            },
                                            text: 'Edit',
                                            btnWidth: 50.w,
                                            btnHeight: 25.h,
                                          );
                                  },
                                  isConsumerAction: true,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Text(widget.sosModel?.photos?[1].typeName ?? '')
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 17.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            '${widget.sosModel?.categoryname}',
                            style: TextStyle(fontSize: 13.sp),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            "(${widget.sosModel?.measureUnit})",
                            style: TextStyle(fontSize: 16.sp, color: blue),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.h),
                      Row(
                        children: [
                          Text(
                            'Actual SOS Percentage  : ',
                            style:
                                TextStyle(fontSize: 16.sp, color: primaryColor),
                          ),
                          Text(
                            '${widget.sosModel?.actualSize} %',
                            style: TextStyle(fontSize: 16.sp, color: blue),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.h),
                      Row(
                        children: [
                          Text(
                            'Actual SOS  : ',
                            style:
                                TextStyle(fontSize: 16.sp, color: primaryColor),
                          ),
                          Text(
                            '${widget.sosModel?.shelfCategorySpace}',
                            style: TextStyle(fontSize: 16.sp, color: blue),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.h),
                      Row(
                        children: [
                          Text(
                            'Total Category Shelf Space : ',
                            style:
                                TextStyle(fontSize: 16.sp, color: primaryColor),
                          ),
                          Text(
                            '${widget.sosModel?.shelfTotalSpace}',
                            style: TextStyle(fontSize: 16.sp, color: blue),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.h),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _showDeleteConfirmationPopup(context),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: greyColor.withOpacity(0.2),
                              child: const Icon(
                                Icons.delete,
                                color: red,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            const Text(
                              'Delete',
                              style: TextStyle(color: red),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            showBottomSheetToEdit(context);
                          },
                          child: SizedBox(
                            width: 120.w,
                            child: Card(
                              color: primaryColor,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: white,
                                      size: 15.sp,
                                    ),
                                    SizedBox(width: 15.w),
                                    const Text(
                                      'Update',
                                      style: TextStyle(color: white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void update({
    required BuildContext context,
    required bool isDelete,
    required bool isPopContext,
    int? indexImage,
  }) {
    context
        .read<UpdateSOSCubit>()
        .updateSOS(
          model: UpdateSOSModel(
            id: widget.sosModel?.id,
            userId: userId,
            delete: isDelete,
            shelfTotalSpace: num.parse(shelfTotalController.text),
            shelfCategorySpace: num.parse(categoryController.text),
            measureUnit: measureUnitController.text,
            visitID: widget.visitId,
            lng: LocationManager.currentPosition?.longitude.toString(),
            lat: LocationManager.currentPosition?.latitude.toString(),
            photos: indexImage == 1
                ? ([
                    Photos(
                      /// const id =>1
                      id: widget.sosModel?.photos?[0].typeID ?? 0,

                      photoPath:
                          pathPhoto ?? widget.sosModel?.photos?[0].photoPath,
                    ),
                    Photos(
                      /// const id=>2
                      id: widget.sosModel?.photos?[1].typeID ?? 0,

                      photoPath: widget.sosModel?.photos?[1].photoPath,
                    ),
                  ])
                : ([
                    Photos(
                      id: widget.sosModel?.photos?[0].typeID ?? 0,

                      /// const
                      photoPath: widget.sosModel?.photos?[0].photoPath,
                    ),
                    Photos(
                      id: widget.sosModel?.photos?[1].typeID ?? 0,

                      /// const
                      photoPath:
                          pathPhoto ?? widget.sosModel?.photos?[1].photoPath,
                    ),
                  ]),
          ),
        )
        .then((value) {
      if (!value.hasError) {
        if (isPopContext) {
          Navigator.pop(context);
        }
        refreshIndicatorSOSKey.currentState?.show();
      } else {
        // Navigator.pop(context);
      }
    });
  }

  /// upload images
  Future<void> _takePhoto(int indexOfImageChanged) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });

      await _uploadPhotoImage(image, indexOfImageChanged);
    }
  }

  Future<void> _uploadPhotoImage(XFile image, int indexOfImageChanged) async {
    String finalImagePath = await createPhotoNameSOS(image, moduleName: "SOS");

    if (indexOfImageChanged == 1) {
      isLoadingSTS = true;
    } else if (indexOfImageChanged == 2) {
      isLoadingSS = true;
    }

    final result = await context
        .read<UpdateImagesCubit>()
        .updateImage(files: [File(finalImagePath)]);

    setState(() {
      pathPhoto = result.data?.imagePathes?[0] ?? "";
      if (indexOfImageChanged == 1) {
        isLoadingSTS = false;
      } else if (indexOfImageChanged == 2) {
        isLoadingSS = false;
      }
    });

    if (!result.hasError) {}
  }

  ///
  void _showDeleteConfirmationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (_) =>
              UpdateSOSCubit(updateCategoryUC: GetIt.I<UpdateCategoryUC>()),
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Delete Confirmation'),
              content: const Text('Are you sure ?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                AppBlocConsumer<UpdateSOSCubit, BaseResponse<EmptyModel?>>(
                  onSuccessBuilder: (context, state) {
                    final isLoading = state.status == RequestStatus.loading;
                    return isLoading
                        ? SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : TextButton(
                            child: const Text('Delete'),
                            onPressed: () {
                              update(
                                context: context,
                                isDelete: true,
                                isPopContext: true,
                              );
                            },
                          );
                  },
                ),
              ],
            );
          }),
        );
      },
    );
  }

  showBottomSheetToEdit(BuildContext context) {
    showModalBottomSheet(
      ///isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BlocProvider<UpdateSOSCubit>(
          create: (_) =>
              UpdateSOSCubit(updateCategoryUC: GetIt.I<UpdateCategoryUC>()),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                //height: 600.h,
                color: white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          'Shelf Category Space',
                          style: TextStyle(color: blue, fontSize: 15.sp),
                        ),
                        SizedBox(
                          width: 200.w,
                          child: TextFormField(
                            controller: categoryController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Shelf Total Space',
                          style: TextStyle(color: blue, fontSize: 15.sp),
                        ),
                        SizedBox(
                          width: 200.w,
                          child: TextFormField(
                            controller: shelfTotalController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Measure Unit',
                          style: TextStyle(color: blue, fontSize: 15.sp),
                        ),
                        SizedBox(
                          width: 200.w,
                          child: TextFormField(
                            controller: measureUnitController,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        SizedBox(height: 50.h),
                        AppBlocConsumer<UpdateSOSCubit,
                            BaseResponse<EmptyModel?>>(
                          onSuccessBuilder: (context, state) {
                            final isLoading =
                                state.status == RequestStatus.loading;
                            return isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Center(
                                    child: LoadingButton(
                                      onPressed: () {
                                        if (num.parse(
                                                categoryController.text) <=
                                            num.parse(
                                                shelfTotalController.text)) {
                                          update(
                                            context: context,
                                            isDelete: false,
                                            isPopContext: true,
                                          );
                                        } else {
                                          Navigator.pop(context);

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                // title: Text('Not Allowed'),
                                                content: const Text(
                                                    'the total space should be largest or equal category space'),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                    },
                                                    child: const Text(
                                                      'Close',
                                                      style: TextStyle(
                                                        color: white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          categoryController.text = widget
                                                  .sosModel
                                                  ?.shelfCategorySpace ??
                                              '';
                                          shelfTotalController.text = widget
                                                  .sosModel?.shelfTotalSpace ??
                                              '';
                                        }
                                      },
                                      text: 'Update',
                                      btnWidth: 200.w,
                                      btnHeight: 40.h,
                                    ),
                                  );
                          },
                          isConsumerAction: true,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
