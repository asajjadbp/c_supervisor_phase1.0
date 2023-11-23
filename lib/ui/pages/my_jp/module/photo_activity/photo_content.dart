import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/my_jp/module/photo_activity/widgets/jp_photos_list.dart';

class JPPhotosContent extends StatelessWidget {
  const JPPhotosContent({
    super.key,
    this.visitId,
  });
  final int? visitId;
  @override
  Widget build(BuildContext context) {
    return JPPhotosList(visitId: visitId ?? 0);
  }
}
