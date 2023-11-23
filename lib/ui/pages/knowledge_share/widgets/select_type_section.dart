import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../styles/colors.dart';
class SelectTypeSection extends StatefulWidget {
  const SelectTypeSection({Key? key}) : super(key: key);

  @override
  State<SelectTypeSection> createState() => _SelectTypeSectionState();
}

class _SelectTypeSectionState extends State<SelectTypeSection> {
  String _paymentMethod = 'Client';

  void _handlePaymentMethodChange(String? value) {
    setState(() {
      _paymentMethod = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio(
              activeColor: primaryColor,
              value: 'Client',
              groupValue: _paymentMethod,
              onChanged: _handlePaymentMethodChange,
            ),
            Text(
              'Client',
              style: TextStyle(fontSize: 16.sp),
            ),
          ],
        ),
        SizedBox(width: 30.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio(
              activeColor: primaryColor,
              value: 'General',
              groupValue: _paymentMethod,
              onChanged: _handlePaymentMethodChange,
            ),
            Text(
              'General',
              style: TextStyle(fontSize: 16.sp),
            ),
          ],
        ),
      ],
    );
  }
}
