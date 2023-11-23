import 'package:c_supervisor/data/models/visits_categories/visit_before_fixing_model.dart';

import '../../../../../common_reusable/image_view.dart';
import '../../../../../index.dart';

class VisitBeforeFixingCard extends StatelessWidget {
  const VisitBeforeFixingCard({
    super.key,
    required this.visitBeforeFixingModel,
  });

  final VisitBeforeFixingModel? visitBeforeFixingModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        elevation: 3,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ImageViewOnAlert(
                isExpanded: true,
                imagePath: visitBeforeFixingModel?.photoPath??'',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
