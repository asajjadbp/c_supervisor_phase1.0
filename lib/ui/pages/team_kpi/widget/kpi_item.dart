import 'package:c_supervisor/ui/pages/team_kpi/index.dart';
import 'package:flutter/cupertino.dart';
class KPIItem extends StatelessWidget {
  const KPIItem({
    Key? key,
    required this.label,
    required this.value,
    this.isPercentageEnabled = true,
  }) : super(key: key);
  final String label;

  final String value;
  final bool isPercentageEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$value${isPercentageEnabled ? '%' : ''}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: primaryColor,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500, color: blue),
          )
        ],
      ),
    );
  }
}
