import 'package:c_supervisor/data/models/companies_brand_data_list_model.dart';
import 'package:c_supervisor/data/models/companies_category_data_list_model.dart';
import 'package:c_supervisor/data/models/companies_data_model.dart';
import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/clients_sku/cubits/companies_brand_data_cubit.dart';
import 'package:c_supervisor/ui/pages/clients_sku/cubits/companies_category_data_cubit.dart';
import 'package:c_supervisor/ui/pages/clients_sku/cubits/companies_sku_data_cubit.dart';

import 'package:flutter_core/tools/request_builder/request_state.dart';
import '../../../../data/models/companies_sku_data_list_model.dart';
import '../../../../domain/use_cases/clients_sku_uc.dart';
import '../../../bloc/app_bloc_consumer.dart';
import 'package:extended_image/extended_image.dart' as prefix;

class ClientsSkuCard extends StatelessWidget {
  const ClientsSkuCard({
    Key? key,
    required this.index,
    required this.companiesDataModel,
  }) : super(key: key);

  final CompaniesDataModel companiesDataModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170.h,
      width: 345.w,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${companiesDataModel.companyName} (${companiesDataModel.companyMode})",
                style: TextStyle(color: blue, fontSize: 13.sp),
              ),
              SizedBox(height: 7.h),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0.w),
                    child: SizedBox(
                      height: 30.h,
                      width: 40.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.r),
                        child: CustomCachedNetworkImage(
                          imgUrl: companiesDataModel
                                  .companylogo?.convertedImagePath ??
                              '',
                          placeholderPath: '',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 70.h,
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 0.h),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          String title = '';

                          switch (index) {
                            case 0:
                              title = 'SKU';
                              break;
                            case 1:
                              title = 'Categories';
                              break;
                            case 2:
                              title = 'Brands';
                              break;
                          }

                          return GestureDetector(
                            onTap: () => getClientData(index, context, title),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.r)),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 13.0),
                                child: Column(
                                  children: [
                                    Text(
                                      index == 0
                                          ? companiesDataModel
                                              .productBarCodesCount
                                              .toString()
                                          : index == 1
                                              ? companiesDataModel.categoryCount
                                                  .toString()
                                              : companiesDataModel.brandCount
                                                  .toString(),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: primaryColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      title,
                                      style: TextStyle(
                                          fontSize: 14.sp, color: blue),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Column(
                            children: [
                              const Text('Client-SLA',
                                  style: TextStyle(color: primaryColor)),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0.h),
                                child:
                                    Divider(thickness: 1.h, color: greyColor),
                              )
                            ],
                          ),
                          content: SingleChildScrollView(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                (companiesDataModel.slaDto ?? []).map((val) {
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 8.0.h),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 35.h,
                                      width: 35.w,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        child: CustomCachedNetworkImage(
                                          imgUrl:
                                              "https://testapi.catalist-me.com/${val.componentImage}",
                                          placeholderPath: '',
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    Expanded(
                                      child: Text(
                                        val.componentName ?? '',
                                        style: TextStyle(
                                            fontSize: 14.sp, color: black),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          )),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/companysla-client.png',
                        height: 30.h,
                        width: 30.w,
                      ),
                      SizedBox(width: 7.w),
                      const Text(
                        'Client SLA',
                        style: TextStyle(color: blue),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getClientData(
    int index,
    BuildContext context,
    String title,
  ) async {
    final int companyID = companiesDataModel.id ?? 0;
    const int langID = 1;
    if (index == 0) {
      showDialog(
        context: context,
        builder: (_) {
          return BlocProvider(
            create: (_) => CompaniesSkuDataCubit(GetIt.I<ClientsSkuUC>())
              ..getCompaniesSkuData(companyID: companyID, langID: langID),
            child: AppBlocConsumer<CompaniesSkuDataCubit,
                BaseResponse<CompaniesSkuDataListModel?>>(
              onSuccessBuilder: (context, state) {
                final isLoading = state.status == RequestStatus.loading;

                return AlertDialog(
                  title: Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(color: primaryColor),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.h),
                        child: Divider(
                          thickness: 1.h,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                  content: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                (state.value?.data?.dataList ?? []).map((val) {
                              return Container(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 8.0.h),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 50.h,
                                        width: 50.w,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                          child: prefix.ExtendedImage.network(
                                            'https://testapi.catalist-me.com/${val.barecodeImage}',
                                            cacheHeight: 300,
                                            cacheWidth: 300,
                                            loadStateChanged:
                                                (prefix.ExtendedImageState
                                                    state) {
                                              switch (state
                                                  .extendedImageLoadState) {
                                                case prefix.LoadState.loading:
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                case prefix.LoadState.completed:
                                                  return prefix
                                                      .ExtendedRawImage(
                                                    image: state
                                                        .extendedImageInfo
                                                        ?.image,
                                                    fit: BoxFit.cover,
                                                  );
                                                case prefix.LoadState.failed:
                                                  return Image.asset(
                                                    'assets/backgrounds/no_image_found.jpg',
                                                    width: 50.w,
                                                    height: 50.h,
                                                  );
                                                default:
                                                  return const SizedBox();
                                              }
                                            },
                                            cache: true,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Expanded(
                                        child: Text(
                                          val.barcodeName ?? '',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ));
                            }).toList(),
                          ),
                        ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            ),
          );
        },
      );

      ///
    } else if (index == 1) {
      showDialog(
        context: context,
        builder: (_) {
          return BlocProvider(
            create: (_) => CompaniesCategoryDataCubit(GetIt.I<ClientsSkuUC>())
              ..getCompaniesCategoryData(companyID: companyID, langID: langID),
            child: AppBlocConsumer<CompaniesCategoryDataCubit,
                BaseResponse<CompaniesCategoryDataListModel?>>(
              onSuccessBuilder: (context, state) {
                final isLoading = state.status == RequestStatus.loading;

                return AlertDialog(
                  title: Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(color: primaryColor),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.h),
                        child: Divider(
                          thickness: 1.h,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                  content: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                (state.value?.data?.dataList ?? []).map((val) {
                              return Container(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 8.0.h),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 50.h,
                                        width: 50.w,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                          child: prefix.ExtendedImage.network(
                                            'https://testapi.catalist-me.com/${val.categoryImage}',
                                            cacheHeight: 300,
                                            cacheWidth: 300,
                                            loadStateChanged:
                                                (prefix.ExtendedImageState
                                                    state) {
                                              switch (state
                                                  .extendedImageLoadState) {
                                                case prefix.LoadState.loading:
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                case prefix.LoadState.completed:
                                                  return prefix
                                                      .ExtendedRawImage(
                                                    image: state
                                                        .extendedImageInfo
                                                        ?.image,
                                                    fit: BoxFit.cover,
                                                  );
                                                case prefix.LoadState.failed:
                                                  return Image.asset(
                                                    'assets/backgrounds/no_image_found.jpg',
                                                    width: 50.w,
                                                    height: 50.h,
                                                  );
                                                default:
                                                  return const SizedBox();
                                              }
                                            },
                                            cache: true,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Expanded(
                                        child: Text(
                                          val.categoryName ?? '',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ));
                            }).toList(),
                          ),
                        ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (_) {
          return BlocProvider(
            create: (_) => CompaniesBrandDataCubit(GetIt.I<ClientsSkuUC>())
              ..getCompaniesBrandData(companyID: companyID, langID: langID),
            child: AppBlocConsumer<CompaniesBrandDataCubit,
                BaseResponse<CompaniesBrandDataListModel?>>(
              onSuccessBuilder: (context, state) {
                final isLoading = state.status == RequestStatus.loading;

                return AlertDialog(
                  title: Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(color: primaryColor),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.h),
                        child: Divider(
                          thickness: 1.h,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                  content: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                (state.value?.data?.dataList ?? []).map((val) {
                              return Container(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 8.0.h),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 50.h,
                                        width: 50.w,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                          child: prefix.ExtendedImage.network(
                                            'https://testapi.catalist-me.com/${val.brandImage}',
                                            cacheHeight: 300,
                                            cacheWidth: 300,
                                            loadStateChanged:
                                                (prefix.ExtendedImageState
                                                    state) {
                                              switch (state
                                                  .extendedImageLoadState) {
                                                case prefix.LoadState.loading:
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                case prefix.LoadState.completed:
                                                  return prefix
                                                      .ExtendedRawImage(
                                                    image: state
                                                        .extendedImageInfo
                                                        ?.image,
                                                    fit: BoxFit.cover,
                                                  );
                                                case prefix.LoadState.failed:
                                                  return Image.asset(
                                                    'assets/backgrounds/no_image_found.jpg',
                                                    width: 50.w,
                                                    height: 50.h,
                                                  );
                                                default:
                                                  return const SizedBox();
                                              }
                                            },
                                            cache: true,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Expanded(
                                        child: Text(
                                          val.brandName ?? '',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ));
                            }).toList(),
                          ),
                        ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
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
  }
}
