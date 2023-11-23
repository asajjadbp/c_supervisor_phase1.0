import 'package:c_supervisor/ui/pages/my_coverage/index.dart';
import 'package:c_supervisor/utilities/mixins/url_lanucher_mixin.dart';

class MyCoverageCard extends StatelessWidget with UrlLauncherMixin {
  const MyCoverageCard({
    super.key,
    required this.index,
    required this.myCoverageModel,
  });
  final int index;
  final MyCoverageModel myCoverageModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      elevation: 4,
      child: Container(
        height: 115.h,
        width: 343.w,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 20.h),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: CustomCachedNetworkImage(
                    imgUrl:
                        "https://testapi.catalist-me.com/${myCoverageModel.photoPath}",
                    placeholderPath: '',
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(myCoverageModel.chainName!),
                    SizedBox(
                      height: 7.h,
                    ),
                    SizedBox(
                      width: 200.w,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        myCoverageModel.storeName!,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 7.h),
                    InkWell(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: SizedBox(
                                width: double.minPositive,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: myCoverageModel.clients!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ListTile(
                                      title: Text(myCoverageModel.clients![index]),
                                      onTap: () {

                                        Navigator.pop(context);

                                      },
                                    );
                                  },
                                  separatorBuilder: (context,index)=>const SizedBox(),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "No Of Clients: ",
                            style: TextStyle(
                              color: blue,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${myCoverageModel.noOfClients}",
                            style: TextStyle(
                              color: black,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 15.0.w),
                            child: InkWell(
                              onTap:()=> openMaps(
                                latitude: myCoverageModel.storeLatitude!,
                                longitude: myCoverageModel.storeLongitude!
                              ) ,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/subermarket_loction.svg',
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: 5.w),
                                  SizedBox(
                                    width: 65.w,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      myCoverageModel.cityName!,
                                      style: TextStyle(
                                        color: black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



}
