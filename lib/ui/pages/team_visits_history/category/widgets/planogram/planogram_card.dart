import 'package:c_supervisor/data/models/update_category/update_planogram_model.dart';
import 'package:c_supervisor/domain/use_cases/update_category/update_category_uc.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/cubits/planogram/update_planogram_cubit.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/planogram/planogram_list.dart';

import '../../../../../../data/models/planogram_reason/planogram_reason_model.dart';
import '../../../../../../data/models/planogram_reason/planogram_reasons_list_model.dart';
import '../../../../../../data/models/visits_categories/planogram_model.dart';
import '../../../../../../utilities/mixins/camera_initializer_helper.dart';
import '../../../../../../utilities/mixins/image_name_creation_mixin.dart';
import '../../../../../../utilities/mixins/location_methods.dart';
import '../../../../../common_reusable/image_view.dart';
import '../../../../../index.dart';
import '../../../../team_kpi/index.dart';
import '../../cubits/planogram/planogram_reasons_cubit.dart';
import '../../cubits/sos/update_images_cubit.dart';

class PlanoGramCard extends StatefulWidget {
  const PlanoGramCard({
    super.key,
    required this.planoGramModel,
    required this.visitId,
  });
  final int visitId;
  final PlanoGramModel? planoGramModel;

  @override
  State<PlanoGramCard> createState() => _PlanoGramCardState();
}

class _PlanoGramCardState extends State<PlanoGramCard>
    with ImageNameCreatorMixin, CameraInitializerMixin {
  bool isCheckboxChecked = false;
  bool isLoading = false;
  bool isYesSelected = false;
  bool isCardChanged = false;
  String? valueReason;
  File? _imageFile;
  String? pathPhoto;
  PlanoGramReasonModel? planoGramReasonModel;
  final userId =
      GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0;
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
    isYesSelected = widget.planoGramModel?.planogramIdentical ?? false;
    return SizedBox(
      width: 350.w,
      //height: 200.h,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ImageViewOnAlert(
                            isExpanded: true,
                            imagePath: widget.planoGramModel?.model ?? ""),
                        SizedBox(height: 5.h),
                        const Text('Model')
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
                              imagePath: widget.planoGramModel?.actual ?? "",
                            ),
                            BlocProvider(
                              create: (_) => UpdatePlanoGramCubit(
                                  updateCategoryUC:
                                      GetIt.I<UpdateCategoryUC>()),
                              child: AppBlocConsumer<UpdatePlanoGramCubit,
                                  BaseResponse<EmptyModel?>>(
                                onSuccessBuilder: (context, state) {
                                  return isLoading
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
                                              isYesSelected = false;
                                              update(
                                                context: context,
                                                isDelete: false,
                                                isPopContext: false,
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
                        const Text('Actual')
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: Row(
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      widget.planoGramModel?.planogramReason == null &&
                              widget.planoGramModel?.planogramIdentical == true
                          ? 'Implemented'
                          : 'Not implemented',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: widget.planoGramModel?.planogramReason == null &&
                                widget.planoGramModel?.planogramIdentical ==
                                    true
                            ? Colors.green
                            : red,
                      ),
                    ),
                    const Spacer(),
                    Text(widget.planoGramModel?.planogramReason ?? "")
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              AppBlocConsumer<PlanoGramReasonsCubit,
                  BaseResponse<PlanoGramReasonListModel?>>(
                onSuccessBuilder: (context, state) {
                  bool isLoading = state.status == RequestStatus.loading;
                  final planoGramReasonsList =
                      state.value?.data?.dataList ?? [];
                  if (widget.planoGramModel?.planogramIdentical == true) {
                    return const SizedBox();
                  }
                  return isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Form(
                          child: Center(
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      label: const Text('Planogram Reason'),
                                      contentPadding: const EdgeInsets.all(12),
                                      // labelText: "hi",
                                      // labelStyle: textStyle,
                                      // labelText: _dropdownValue == null
                                      //     ? 'Where are you from'
                                      //     : 'From',
                                      // errorText: "Wrong Choice",
                                      errorStyle: const TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 16.0),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<PlanoGramReasonModel>(
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontFamily: "verdana_regular",
                                      ),
                                      hint: Text(
                                        widget.planoGramModel
                                                ?.planogramReason ??
                                            " Select Planogram Reason",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontFamily: "verdana_regular",
                                        ),
                                      ),
                                      items: planoGramReasonsList.map<
                                              DropdownMenuItem<
                                                  PlanoGramReasonModel>>(
                                          (PlanoGramReasonModel value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(value.typeName ?? ''),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                      isExpanded: true,
                                      isDense: true,
                                      onChanged: (PlanoGramReasonModel?
                                          newSelectedBank) {
                                        setState(() {
                                          planoGramReasonModel =
                                              newSelectedBank;
                                          valueReason =
                                              newSelectedBank?.typeName;
                                        });
                                      },
                                      value: planoGramReasonModel,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                },
              ),
              Row(
                children: [
                  Text(
                    'Planogram Identical',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isYesSelected = true;
                            widget.planoGramModel?.planogramIdentical = true;
                            isCardChanged =
                                true; // Set the flag to true when the card is changed
                          });
                        },
                        child: Card(
                          color:
                              widget.planoGramModel?.planogramIdentical == true
                                  ? Colors.green
                                  : white,
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('Yes'),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isYesSelected = false;
                            widget.planoGramModel?.planogramIdentical = false;
                            isCardChanged =
                                true; // Set the flag to true when the card is changed
                          });
                        },
                        child: Card(
                          color:
                              widget.planoGramModel?.planogramIdentical == false
                                  ? red
                                  : white,
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('No'),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 10.h),
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
                    BlocProvider(
                      create: (_) => UpdatePlanoGramCubit(
                          updateCategoryUC: GetIt.I<UpdateCategoryUC>()),
                      child: AppBlocConsumer<UpdatePlanoGramCubit,
                          BaseResponse<EmptyModel?>>(
                        onSuccessBuilder: (context, state) {
                          final isLoading =
                              state.status == RequestStatus.loading;
                          return isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              /*
                          onTap: () {
                                      if (isCardChanged) {
                                        if (isYesSelected == false &&
                                            valueReason == null) {
                                          "Please Select Plano Gram"
                                              .showToast();
                                        } else {
                                          update(
                                            context: context,
                                            isDelete: false,
                                            isPopContext: false,
                                          );
                                        }
                                      }
                                    },
                           */
                              : Align(
                                  alignment: Alignment.bottomRight,
                                  child: InkWell(
                                    onTap: () {
                                      if (isCardChanged ||
                                          planoGramReasonModel?.id != null ||
                                          widget.planoGramModel?.reasonId !=
                                              null) {
                                        if (isYesSelected == false &&
                                            valueReason == null) {
                                          "Please Select Planogram Reason"
                                              .showToast();
                                        } else {
                                          update(
                                            context: context,
                                            isDelete: false,
                                            isPopContext: false,
                                          );
                                        }
                                      }
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
                                              SizedBox(width: 5.w),
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
                                );
                        },
                        isConsumerAction: true,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (_) => UpdatePlanoGramCubit(
              updateCategoryUC: GetIt.I<UpdateCategoryUC>()),
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
                  AppBlocConsumer<UpdatePlanoGramCubit,
                      BaseResponse<EmptyModel?>>(
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
            },
          ),
        );
      },
    );
  }

  void update({
    required BuildContext context,
    required bool isDelete,
    required bool isPopContext,
  }) {
    context
        .read<UpdatePlanoGramCubit>()
        .updatePlanoGram(
          model: UpdatePlanoGramModel(
            id: widget.planoGramModel?.id,
            userId: userId,
            delete: isDelete,
            visitID: widget.visitId,
            lng: LocationManager.currentPosition?.longitude.toString(),
            lat: LocationManager.currentPosition?.latitude.toString(),

            ///

            /// planogramReason: planoGramReasonModel?.id ?? 0,
            planogramReason: getPlanoGramReason(),
            identical: isYesSelected,

            ///
            imagePath: pathPhoto ?? widget.planoGramModel?.actual,
          ),
        )
        .then((value) {
      if (!value.hasError) {
        if (isPopContext) {
          Navigator.pop(context);
        }
        refreshIndicatorPlanoGramKey.currentState?.show();
      } else {
        //Navigator.pop(context);
      }
    });
  }

  int? getPlanoGramReason() {
    int? planoGramReason = 0;
    if (isYesSelected) {
      planoGramReason = null;
      return planoGramReason;
    } else {
      planoGramReason =
          planoGramReasonModel?.id ?? widget.planoGramModel?.reasonId;

      return planoGramReason;
    }
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

    isLoading = true;

    final result = await context
        .read<UpdateImagesCubit>()
        .updateImage(files: [File(finalImagePath)]);

    setState(() {
      pathPhoto = result.data?.imagePathes?[0] ?? "";

      isLoading = false;
    });

    if (!result.hasError) {}
  }

  ///
}
