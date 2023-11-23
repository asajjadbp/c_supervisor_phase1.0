import 'package:c_supervisor/utilities/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class DrawerIconButton extends StatelessWidget {
  const DrawerIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(PostAuthRoutes.setting.route.path),
      child: SvgPicture.asset(
        'assets/icons/menu_ic.svg',
      ),
    );
  }
}
