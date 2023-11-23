import 'package:c_supervisor/ui/pages/my_coverage/index.dart';

import '../bottom_sheet_upload_files/upload_item_file.dart';

class UploadedFilesContent extends StatefulWidget {
  const UploadedFilesContent({
    Key? key,
    required this.moduleName,
  }) : super(key: key);

  final String moduleName;

  @override
  State<UploadedFilesContent> createState() => _UploadedFilesContentState();
}

class _UploadedFilesContentState extends State<UploadedFilesContent> {
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
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '10 Files',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/upload.svg'),
                          SizedBox(width: 6.w),
                          Text('Upload',
                              style: TextStyle(
                                  fontSize: 16.sp, color: primaryColor))
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Divider(thickness: 1.h, color: greyColor),
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 10.h),
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return const UploadedItemFile(
                        loading: false,
                        fileExtension: '',
                        uploadedCompleted: true,
                        lineColor: red,
                        fileName: '',
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UploadedItemFile extends StatelessWidget {
  const UploadedItemFile({
    Key? key,
    required this.lineColor,
    required this.fileName,
    required this.uploadedCompleted,
    required this.fileExtension,
    required this.loading,
  }) : super(key: key);

  final Color lineColor;
  final String fileName;
  final bool uploadedCompleted;
  final String fileExtension;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310.w,
      height: 115.h,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Row(
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
                child: const Center(
                  child: GetFileImage(fileExtension: ".pdf"),
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
                            'widget.fileName',
                            style: TextStyle(fontSize: 12.sp),
                            //overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                        uploadedCompleted
                            ? Icon(
                                Icons.check_circle,
                                color: getLoadingAndIconColor(
                                    fileExtension: fileExtension),
                              )
                            : const Icon(
                                Icons.cancel,
                                color: greyColor,
                              ),
                      ],
                    ),
                    SizedBox(height: 17.h),
                    if (loading)
                      Center(
                        child: LinearProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              getLoadingAndIconColor(
                                  fileExtension: fileExtension)),
                        ),
                      )
                    else
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: getLoadingAndIconColor(
                              fileExtension: fileExtension),
                        ),
                        height: 5,
                        width: MediaQuery.of(context).size.width / 1.4.w,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
