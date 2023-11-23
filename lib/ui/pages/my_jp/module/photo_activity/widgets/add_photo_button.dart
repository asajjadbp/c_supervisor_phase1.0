// import '../../../../../../domain/use_cases/sup_visits_uc.dart';
// import '../../../../../../utilities/mixins/image_name_creation_mixin.dart';
// import '../../../../../index.dart';
// import '../../../../team_kpi/index.dart';
// import '../../../cubits/upload_image_cubit.dart';
//
// class BuildAddPhotoButton extends StatefulWidget {
//   BuildAddPhotoButton({
//     super.key,
//     this.visitId,
//   });
//
//   int? visitId;
//
//   @override
//   State<BuildAddPhotoButton> createState() => _BuildAddPhotoButtonState();
// }
//
// class _BuildAddPhotoButtonState extends State<BuildAddPhotoButton>
//     with ImageNameCreatorMixin {
//   bool isLoading = false;
//   String? photoPath;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         _takePhoto(context);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: primaryColor,
//           borderRadius: BorderRadius.circular(15.r),
//         ),
//         width: 150.w,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             children: [
//               Text(
//                 'Add Photo',
//                 style: TextStyle(
//                   color: white,
//                   fontSize: 18.sp,
//                 ),
//               ),
//               const Spacer(),
//               Icon(
//                 Icons.add_a_photo,
//                 color: white,
//                 size: 22.sp,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _takePhoto(BuildContext context) async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.camera);
//
//     if (image != null) {
//       bool isLoading = false;
//
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return StatefulBuilder(
//             builder: (context, setState) {
//               return AlertDialog(
//                 title: Text("Captured Photo"),
//                 content: isLoading
//                     ? Container(
//                         height: 50.h,
//                         child: Center(child: const CircularProgressIndicator()),
//                       )
//                     : Image.file(File(image
//                         .path)), // Display the captured image or loading indicator.
//                 actions: <Widget>[
//                   TextButton(
//                     child: Text("Cancel"),
//                     onPressed: () {
//                       Navigator.of(context).pop(); // Close the dialog.
//                     },
//                   ),
//                   TextButton(
//                     child: isLoading ? Text("Uploading...") : Text("OK"),
//                     onPressed: isLoading
//                         ? null // Disable the button when loading
//                         : () async {
//                             setState(() {
//                               isLoading = true; // Set loading state to true
//                             });
//
//                             // Upload the captured image.
//                             await _uploadPhotoImage(
//                               visitId: widget.visitId ?? 0,
//                               context: context,
//                               image: image,
//                             );
//
//                             Navigator.of(context).pop(); // Close the dialog.
//                           },
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//       );
//     }
//   }
//
//   Future<void> _uploadPhotoImage(
//       {required XFile image,
//       required int visitId,
//       required BuildContext context}) async {
//     String finalImagePath = await createPhotoNameMyJP(
//       visitId: visitId,
//       image,
//       moduleName: "SupVisits",
//     );
//     isLoading = true;
//     final result = await context
//         .read<UploadImageJPCubit>()
//         .uploadImageJP(files: [File(finalImagePath)]);
//
//     photoPath = result.data?.imagePathes?[0] ?? "";
//
//     isLoading = false;
//
//     if (!result.hasError) {
//       //startVisitRequest(model);
//       // refreshPage();
//     }
//   }
// }
