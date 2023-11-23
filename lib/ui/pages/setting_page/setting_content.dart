import 'package:c_supervisor/styles/colors.dart';
import 'package:c_supervisor/ui/bloc/auth_cubit.dart';
import 'package:c_supervisor/ui/common_reusable/brand_reusable.dart';
import 'package:c_supervisor/ui/common_reusable/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../data/data_sources/local/app_shared_prefs_client.dart';

class SettingContent extends StatelessWidget {
  const SettingContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BrandReusable.withAnyHeader(
        isWidgetStacked: true,
        withStackedImage: true,
        header: const AppHeader(
          shouldShowAvatar: false,
          prefixHeaderWidgets: [
            BackIconButton(),
          ],
          headerTitle: '',
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 140.w),
          child: Column(
            children: [
              Text(
                GetIt.I<AppSharedPrefsClient>()
                        .getCurrentUserInfo()
                        ?.fullName ??
                    '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: primaryColor,
                    fontSize: 22.sp),
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                GetIt.I<AppSharedPrefsClient>()
                        .getCurrentUserInfo()
                        ?.userEmail ??
                    '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 18.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              SettingItem(
                iconName: 'logout_ic.svg',
                title: 'Logout',
                onPressed: () {
                  context.showAppDialog(
                      titleTextAlignment: TextAlign.center,
                      subtitleStyle:
                          const TextStyle(color: Colors.black, fontSize: 15),
                      title: 'Logout',
                      barrierDismissible: true,
                      footerActions: [
                        MaterialButton(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Text(
                            'No',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        MaterialButton(
                          color: blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Text(
                            'Yes',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                          onPressed: () => logoutProcess(context),
                        )
                      ],
                      subtitle: 'Are You sure logout ?');
                },
              )
            ],
          ),
        ));
  }

  logoutProcess(BuildContext context) {
    GetIt.I<AuthCubit>().emitUnauthorizedState();
  }
}

class SettingItem extends StatelessWidget {
  const SettingItem(
      {Key? key,
      required this.title,
      required this.iconName,
      required this.onPressed})
      : super(key: key);

  final String title;
  final String iconName;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed.call(),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Card(
            color: Colors.white70.withAlpha(240),
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.black12,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 60.h,
              padding: EdgeInsets.all(15.w),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/$iconName',
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 18.sp),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
