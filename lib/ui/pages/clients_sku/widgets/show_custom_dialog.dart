// import 'package:c_supervisor/ui/index.dart';
// import 'package:extended_image/extended_image.dart';
//
// showCustomDialog({
//   required TypeOfIndex typeOfIndex,
//   required BuildContext context,
//   required String dialogTitle,
//   required List<dynamic> dataList,
// }) {
//   return showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Column(
//           children: [
//             Text(
//               dialogTitle,
//               style: const TextStyle(color: primaryColor),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 8.0.h),
//               child: Divider(
//                 thickness: 1.h,
//                 color: greyColor,
//               ),
//             ),
//           ],
//         ),
//         content: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: dataList.map((val) {
//               switch (typeOfIndex) {
//                 case TypeOfIndex.sku:
//                   return Container(
//                       padding: EdgeInsets.symmetric(vertical: 8.0.h),
//                       child: Row(
//                         children: [
//                           SizedBox(
//                             height: 50.h,
//                             width: 50.w,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(6.r),
//                               child: ExtendedImage.network(
//                                 'https://testapi.catalist-me.com/${val.barecodeImage}',
//                                 cacheHeight: 300,
//                                 cacheWidth: 300,
//                                 loadStateChanged: (ExtendedImageState state) {
//                                   switch (state.extendedImageLoadState) {
//                                     case LoadState.loading:
//                                       return const Center(
//                                         child: CircularProgressIndicator(),
//                                       );
//                                     case LoadState.completed:
//                                       return ExtendedRawImage(
//                                         image: state.extendedImageInfo?.image,
//                                         fit: BoxFit.cover,
//                                       );
//                                     case LoadState.failed:
//                                       return Image.asset(
//                                         'assets/backgrounds/no_image_found.jpg',
//                                         width: 50.w,
//                                         height: 50.h,
//                                       );
//                                     default:
//                                       return const SizedBox();
//                                   }
//                                 },
//                                 cache: true,
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 5.w),
//                           Expanded(
//                             child: Text(
//                               val.barcodeName ?? '',
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                                 color: black,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ));
//
//                 case TypeOfIndex.categories:
//                   return Container(
//                     padding: EdgeInsets.symmetric(vertical: 8.0.h),
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           height: 50.h,
//                           width: 50.w,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(6.r),
//                             child: ExtendedImage.network(
//                               'https://testapi.catalist-me.com/${val.categoryImage}',
//                               cacheHeight: 300,
//                               cacheWidth: 300,
//                               loadStateChanged: (ExtendedImageState state) {
//                                 switch (state.extendedImageLoadState) {
//                                   case LoadState.loading:
//                                     return const Center(
//                                       child: CircularProgressIndicator(),
//                                     );
//                                   case LoadState.completed:
//                                     return ExtendedRawImage(
//                                       image: state.extendedImageInfo?.image,
//                                       fit: BoxFit.cover,
//                                     );
//                                   case LoadState.failed:
//                                     return Image.asset(
//                                       'assets/backgrounds/no_image_found.jpg',
//                                       width: 50.w,
//                                       height: 50.h,
//                                     );
//                                   default:
//                                     return const SizedBox();
//                                 }
//                               },
//                               cache: true,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 5.w),
//                         Expanded(
//                           child: Text(
//                             val.categoryName ?? '',
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               color: black,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 case TypeOfIndex.brands:
//                   return Container(
//                     padding: EdgeInsets.symmetric(vertical: 8.0.h),
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           height: 50.h,
//                           width: 50.w,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(6.r),
//                             child: ExtendedImage.network(
//                               'https://testapi.catalist-me.com/${val.brandImage}',
//                               cacheHeight: 300,
//                               cacheWidth: 300,
//                               loadStateChanged: (ExtendedImageState state) {
//                                 switch (state.extendedImageLoadState) {
//                                   case LoadState.loading:
//                                     return const Center(
//                                       child: CircularProgressIndicator(),
//                                     );
//                                   case LoadState.completed:
//                                     return ExtendedRawImage(
//                                       image: state.extendedImageInfo?.image,
//                                       fit: BoxFit.cover,
//                                     );
//                                   case LoadState.failed:
//                                     return Image.asset(
//                                       'assets/backgrounds/no_image_found.jpg',
//                                       width: 50.w,
//                                       height: 50.h,
//                                     );
//                                   default:
//                                     return const SizedBox();
//                                 }
//                               },
//                               cache: true,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 5.w),
//                         Expanded(
//                           child: Text(
//                             val.brandName ?? '',
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               color: black,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//               }
//             }).toList(),
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('OK'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
//
// enum TypeOfIndex { sku, categories, brands }
