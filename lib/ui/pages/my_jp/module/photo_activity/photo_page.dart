import 'package:c_supervisor/domain/use_cases/sup_visits_uc.dart';
import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/my_jp/module/photo_activity/cubits/action_photo_cubit.dart';
import 'package:c_supervisor/ui/pages/my_jp/module/photo_activity/cubits/jp_photos_cubit.dart';
import 'package:c_supervisor/ui/pages/my_jp/module/photo_activity/photo_content.dart';
import 'package:c_supervisor/ui/pages/my_jp/module/photo_activity/widgets/jp_photos_list.dart';

import '../../../../../data/models/sup_visits/to_json/add_photo_to_json_model.dart';
import '../../../../../utilities/mixins/image_name_creation_mixin.dart';
import '../../../team_kpi/index.dart';
import '../../cubits/upload_image_cubit.dart';

class JPPhotosPage extends StatefulWidget {
  const JPPhotosPage({
    super.key,
    this.visitId,
  });

  final int? visitId;

  @override
  State<JPPhotosPage> createState() => _JPPhotosPageState();
}

class _JPPhotosPageState extends State<JPPhotosPage>
    with ImageNameCreatorMixin {
  bool isLoading = false;
  String? photoPath;

  @override
  Widget build(BuildContext context) {
    ///todo
    return MultiBlocProvider(
      providers: [
        BlocProvider<JPPhotosCubit>(
          create: (_) => JPPhotosCubit(supVisitsUC: GetIt.I<SupVisitsUC>())
            ..getJPPhotos(visitId: widget.visitId ?? 0),
        ),
        BlocProvider<ActionPhotoCubit>(
          create: (_) => ActionPhotoCubit(supVisitsUC: GetIt.I<SupVisitsUC>()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Journey Plan Photos',
            style: TextStyle(
              color: white,
              fontSize: 20.sp,
            ),
          ),
          elevation: 0.0,
          iconTheme: const IconThemeData(color: white),
        ),
        body: JPPhotosContent(visitId: widget.visitId ?? 0),
        floatingActionButton: GestureDetector(
          onTap: () {
            _takePhoto(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(15.r),
            ),
            width: 150.w,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    'Add Photo',
                    style: TextStyle(
                      color: white,
                      fontSize: 18.sp,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.add_a_photo,
                    color: white,
                    size: 22.sp,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _takePhoto(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      bool isLoading = false;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<UploadImageJPCubit>(
                create: (_) =>
                    UploadImageJPCubit(supVisitsUC: GetIt.I<SupVisitsUC>()),
              ),
              BlocProvider<ActionPhotoCubit>(
                create: (_) =>
                    ActionPhotoCubit(supVisitsUC: GetIt.I<SupVisitsUC>()),
              ),
            ],
            child: StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: const Text("Captured Photo"),
                  content: isLoading
                      ? SizedBox(
                          height: 50.h,
                          child:
                              const Center(child: CircularProgressIndicator()),
                        )
                      : Image.file(File(image.path)),
                  // Display the captured image or loading indicator.
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
                                visitId: widget.visitId ?? 0,
                                context: context,
                                image: image,
                              );

                              Navigator.of(context).pop(); // Close the dialog.
                            },
                      child: isLoading ? const Text("Uploading...") : const Text("OK"),
                    ),
                  ],
                );
              },
            ),
          );
        },
      );
    }
  }

  Future<void> _uploadPhotoImage(
      {required XFile image,
      required int visitId,
      required BuildContext context}) async {
    String finalImagePath = await createPhotoNameMyJP(
      visitId: visitId,
      image,
      moduleName: "SupVisits",
    );
    isLoading = true;
    final result = await context
        .read<UploadImageJPCubit>()
        .uploadImageJP(files: [File(finalImagePath)]);

    photoPath = result.data?.imagePathes?[0] ?? "";

    isLoading = false;

    if (!result.hasError) {
      addPhoto(context);
      // refreshPage();
    }
  }

  Future<void> addPhoto(BuildContext context) async {
    final result = await context.read<ActionPhotoCubit>().addPhoto(
          model: AddPhotoToJsonModel(
            visitID: widget.visitId ?? 0,
            photoPath: photoPath ?? "",
          ),
        );
    if (result.message == "Success") {
      refreshIndicatorPhotosKey.currentState?.show();
    }
  }
}
