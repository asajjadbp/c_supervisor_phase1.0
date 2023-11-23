import '../../../index.dart';

// class UploadItemFile extends StatefulWidget {
//   const UploadItemFile({
//     Key? key,
//     required this.fileName,
//     required this.fileExtension,
//     required this.isLoading,
//   }) : super(key: key);
//
//   final String fileName;
//   final String fileExtension;
//   final bool isLoading;
//
//   @override
//   State<UploadItemFile> createState() => _UploadItemFileState();
// }
//
// class _UploadItemFileState extends State<UploadItemFile> {
//   bool _isCurrentlyLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _isCurrentlyLoading = widget.isLoading;
//   }
//
//   @override
//   void didUpdateWidget(UploadItemFile oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.isLoading != widget.isLoading) {
//       setState(() {
//         _isCurrentlyLoading = widget.isLoading;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 8.0.w),
//         child: Row(
//           children: [
//             Container(
//               height: 70.h,
//               width: 70.w,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.r),
//                 border: Border.all(
//                   color: greyColor.withOpacity(0.5),
//                 ),
//               ),
//               child: Center(
//                 child: GetFileImage(fileExtension: widget.fileExtension),
//               ),
//             ),
//             SizedBox(width: 14.w),
//             Expanded(
//               flex: 3,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           widget.fileName,
//                           style: TextStyle(fontSize: 12.sp),
//                           //overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       const Spacer(),
//                       !_isCurrentlyLoading
//                           ? Icon(
//                         Icons.check_circle,
//                         color: getLoadingAndIconColor(
//                           fileExtension: widget.fileExtension,
//                         ),
//                       )
//                           : const Icon(
//                         Icons.cancel,
//                         color: greyColor,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 17.h),
//                   if (_isCurrentlyLoading)
//                     Center(
//                       child: LinearProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(
//                           getLoadingAndIconColor(
//                             fileExtension: widget.fileExtension,
//                           ),
//                         ),
//                       ),
//                     )
//                   else
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15.r),
//                         color: getLoadingAndIconColor(
//                           fileExtension: widget.fileExtension,
//                         ),
//                       ),
//                       height: 5,
//                       width: MediaQuery.of(context).size.width / 1.4.w,
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class GetFileImage extends StatelessWidget {
  const GetFileImage({
    Key? key,
    required this.fileExtension,
  }) : super(key: key);
  final String fileExtension;

  @override
  Widget build(BuildContext context) {
    switch (fileExtension) {
      case '.jpg':
        return SvgPicture.asset('assets/icons/gallery.svg');
      case '.pdf':
        return SvgPicture.asset('assets/icons/pdf.svg');
      case '.docx':
        return SvgPicture.asset('assets/icons/docx.svg');
      default:
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Image.asset('assets/backgrounds/no_image_found.jpg'),
          ),
        );
    }
  }
}

Color getLoadingAndIconColor({required String fileExtension}) {
  switch (fileExtension) {
    case '.jpg':
      return primaryColor;
    case '.pdf':
      return black;
    case '.docx':
      return blue;
    default:
      return blue;
  }
}
