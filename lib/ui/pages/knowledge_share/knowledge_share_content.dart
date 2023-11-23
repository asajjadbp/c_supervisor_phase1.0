import '../team_kpi/index.dart';
import 'bottom_sheet_upload_files/upload_item_file.dart';
import 'index.dart';
import 'package:path/path.dart' as p;

class KnowledgeShareContent extends StatefulWidget {
  const KnowledgeShareContent({
    Key? key,
    required this.moduleName,
  }) : super(key: key);

  final String moduleName;

  @override
  State<KnowledgeShareContent> createState() => _KnowledgeShareContentState();
}

class _KnowledgeShareContentState extends State<KnowledgeShareContent>
    with FilesNameCreatorMixin {
  bool isLoading = false;
  XFile? xFile;
  KnowledgeBaseCategoriesModel? selectedCategory;
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
          headerTitle: widget.moduleName,
        ),
      ),
      child: AppBlocConsumer<KnowledgeBaseCategoriesCubit,
          BaseResponse<KnowledgeBaseCategoriesListModel?>>(
        onSuccessBuilder: (context, state) {
          final isLoadingCategoriesList = state.status == RequestStatus.loading;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: isLoadingCategoriesList
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Choose File',
                                style: TextStyle(fontSize: 16.sp)),
                            SizedBox(height: 10.h),
                            GestureDetector(
                              onTap: () async {
                                if (isLoading == true) {
                                  "wait for loading file to complete"
                                      .showMyDialogHelper(context);
                                } else {
                                  if (selectedCategory?.id != null) {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      allowMultiple: false,
                                      type: FileType.custom,
                                      allowedExtensions: [
                                        'pdf',
                                        'xlsx',
                                        'xls',
                                        'doc',
                                        'png',
                                        'jpeg',
                                        'docx',
                                        'ppt',
                                        'pptx',
                                        'jpg'
                                      ],
                                    );
                                    if (result != null) {
                                      xFile = XFile(result.files.single.path!);

                                      // Check file size
                                      if (getFileSizeInMB(xFile!) > 5) {
                                        'File size cannot exceed 5MB'
                                            .showMyDialogHelper(context);
                                        return;
                                      }

                                      _uploadFiles(xFile!);
                                    }
                                  } else {
                                    'Please Select Section'
                                        .showMyDialogHelper(context);
                                  }
                                }
                              },
                              child: const UploadFileSection(),
                            ),
                            SizedBox(height: 24.h),
                            Text('Select Section',
                                style: TextStyle(fontSize: 16.sp)),
                            SizedBox(height: 10.h),
                            FileForSection(
                              dataList: state.value?.data?.dataList ?? [],
                              selectedCategory: (value) {
                                selectedCategory = value;
                              },
                            ),
                            SizedBox(height: 20.h),
                            showFile()
                                ? buildFileWidget(xFile!)
                                : const SizedBox()
                          ],
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _uploadFiles(XFile file) async {
    final userID =
        GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0;
    String finalImagePath =
        await createFileName(file, moduleName: "UserUploadFile");

    setState(() {
      isLoading = true;
    });

    /// Check if the file exists at the specified path
    if (!await File(finalImagePath).exists()) {
      if (kDebugMode) {
        print('Error: File not found.');
      }
      return;
    }

    buildFileWidget(file);

    try {
      final resultUploadFile = await context
          .read<UploadFileCubit>()
          .uploadFiles(files: [File(finalImagePath)]);
      final resultAddFile = await context.read<AddFileCubit>().addFile(
            addFileModel: AddFileModel(
              userId: userID,
              categoryId: selectedCategory?.id,
              fileDesc: '',
              fileName: p.basename(xFile!.path),
              filePath: resultUploadFile.data?.imagePathes?[0] ?? ''
                ..replaceAll('\\', '/'),
            ),
          );

      if (!resultUploadFile.hasError && !resultAddFile.hasError) {
        //addFile(result.data?.imagePathes?[0] ?? '');
        'Uploaded Successfully'.showMyDialogHelper(context);
        setState(() {
          isLoading = false;
        });
      } else {
        'Failed to upload file,try again'.showMyDialogHelper(context);

        setState(() {
          xFile = null;
          isLoading=false;
        });
        showFile();
      }
    } catch (e) {}
  }

  // Future<void> addFile(String filePath) async {
  //   final userID =
  //       GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0;
  //   final BaseResponse<EmptyModel?> result =
  //       await context.read<AddFileCubit>().addFile(
  //             addFileModel: AddFileModel(
  //               userId: userID,
  //               categoryId: selectedCategory?.id,
  //               fileDesc: '',
  //               fileName: p.basename(xFile!.path),
  //               filePath: filePath..replaceAll('\\', '/'),
  //             ),
  //           );
  //   if (result.hasError) {
  //   } else {}
  // }

  Widget buildFileWidget(XFile file) {
    String fileName = p.basename(file.path);

    return Row(
      children: [
        Container(
          height: 70.h,
          width: 70.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(
              color: greyColor.withOpacity(0.5),
            ),
          ),
          child: Center(
            child: GetFileImage(fileExtension: p.extension(fileName)),
          ),
        ),
        SizedBox(width: 14.w),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      ' $fileName',
                      style: TextStyle(fontSize: 12.sp),
                      //overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  !isLoading
                      ? Icon(
                          Icons.check_circle,
                          color: getLoadingAndIconColor(
                            fileExtension: p.extension(fileName),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              SizedBox(height: 17.h),
              if (isLoading)
                Center(
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      getLoadingAndIconColor(
                        fileExtension: p.extension(fileName),
                      ),
                    ),
                  ),
                )
              else
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: getLoadingAndIconColor(
                      fileExtension: p.extension(fileName),
                    ),
                  ),
                  height: 5,
                  width: MediaQuery.of(context).size.width / 1.4.w,
                ),
            ],
          ),
        ),
      ],
    );
  }

  bool showFile() {
    bool isShow;
    if (xFile != null) {
      isShow = true;
    } else {
      isShow = false;
    }

    return isShow;
  }

  double getFileSizeInMB(XFile file) {
    final bytes = File(file.path).lengthSync();
    return bytes / (1024 * 1024);
  }
}
