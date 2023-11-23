// import 'package:c_supervisor/ui/pages/knowledge_share/bottom_sheet_upload_files/upload_item_file.dart';
// import 'package:c_supervisor/ui/pages/knowledge_share/uploaded_files/uploaded_files_page.dart';
// import 'package:c_supervisor/ui/pages/team_kpi/index.dart';
//
// import '../../../index.dart';
// import 'package:path/path.dart';
// import 'package:path/path.dart' as path;
//
// class BottomSheetUploadFilesContent extends StatelessWidget {
//   const BottomSheetUploadFilesContent({
//     Key? key,
//     required this.uploadedFilesPath,
//     required this.isLoading,
//   }) : super(key: key);
//
//   final List<String> uploadedFilesPath;
//   final bool isLoading;
//
//   @override
//   Widget build(BuildContext context) {
//     print('isLoading');
//     print(isLoading);
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
//       child: Column(
//         children: [
//           SizedBox(height: 20.h),
//           Text(
//             'Upload',
//             style: TextStyle(fontSize: 16.sp, color: blue),
//           ),
//           SizedBox(height: 20.h),
//           Divider(thickness: 1.5.h, color: greyColor),
//           Expanded(
//             child: ListView.separated(
//               itemBuilder: (context, index) {
//                 String fileName = basename(uploadedFilesPath[index]);
//                 return UploadItemFile(
//                   isLoading: isLoading,
//                   fileExtension: path.extension(fileName),
//                   fileName: fileName,
//                 );
//               },
//               itemCount: uploadedFilesPath.length,
//               separatorBuilder: (context, index) => SizedBox(height: 30.h),
//             ),
//           ),
//           SizedBox(height: 20.h),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: LoadingButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (_) =>
//                             const UploadedFilesPage(moduleName: 'moduleName')));
//               },
//               borderRadius: 7.r,
//               btnHeight: 55.h,
//               btnWidth: 320.w,
//               text: 'CONFIRM',
//               style: TextStyle(fontSize: 18.sp, color: white),
//             ),
//           ),
//           SizedBox(height: 20.h),
//         ],
//       ),
//     );
//   }
// }
