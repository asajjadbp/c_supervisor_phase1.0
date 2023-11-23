import 'package:c_supervisor/ui/index.dart';

class UploadFileSection extends StatefulWidget {
  const UploadFileSection({Key? key}) : super(key: key);

  @override
  State<UploadFileSection> createState() => _UploadFileSectionState();
}

class _UploadFileSectionState extends State<UploadFileSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      width: 330.w,
      child: SvgPicture.asset('assets/backgrounds/upload_files.svg'),
    );
  }
}
