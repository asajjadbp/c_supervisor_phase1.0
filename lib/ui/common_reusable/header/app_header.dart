import 'package:c_supervisor/data/data_sources/local/index.dart';
import 'package:c_supervisor/di/environment_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/widgets/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

class AppHeader extends StatelessWidget {
  const AppHeader(
      {Key? key,
      required this.prefixHeaderWidgets,
      required this.headerTitle,
      this.shouldShowAvatar = true})
      : super(key: key);
  final List<Widget> prefixHeaderWidgets;
  final String headerTitle;
  final bool? shouldShowAvatar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: prefixHeaderWidgets,
              ),
              shouldShowAvatar ?? true
                  ? CircleAvatar(
                      child: ClipOval(
                          child: CustomCachedNetworkImage(
                              width: 40,
                              height: 40,
                              imgUrl: EnvironmentType
                                      .development.environment.baseURL +
                                  (GetIt.I<AppSharedPrefsClient>()
                                          .getCurrentUserInfo()
                                          ?.photoPath ??
                                      ''),
                              placeholderPath: '')),
                    )
                  : const SizedBox()
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            headerTitle,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
