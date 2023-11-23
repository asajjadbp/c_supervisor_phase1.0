import 'package:c_supervisor/domain/use_cases/sup_visits_uc.dart';
import 'package:c_supervisor/ui/pages/my_jp/module/photo_activity/cubits/action_photo_cubit.dart';
import 'package:c_supervisor/ui/pages/my_jp/module/photo_activity/widgets/jp_photos_list.dart';

import '../../../../../../data/models/sup_visits/modules/photos/jp_photos_model.dart';
import '../../../../../../utilities/mixins/image_name_creation_mixin.dart';
import '../../../../../common_reusable/image_view.dart';
import '../../../../../index.dart';
import '../../../../team_kpi/index.dart';

class JPPhotosCard extends StatefulWidget {
  JPPhotosCard({
    super.key,
    required this.model,
    this.visitId,
  });

  final JPPhotosModel? model;
  int? visitId;

  @override
  State<JPPhotosCard> createState() => _JPPhotosCardState();
}

class _JPPhotosCardState extends State<JPPhotosCard>
    with ImageNameCreatorMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ActionPhotoCubit>(
      create: (context) =>
          ActionPhotoCubit(supVisitsUC: GetIt.I<SupVisitsUC>()),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ImageViewOnAlert(
            imagePath: widget.model?.photoPath ?? "",
            isExpanded: true,
            baserUrl: "https://supapitest.catalist-me.com/",
          ),
          Padding(
            padding: EdgeInsets.only(right: 30.0.w, bottom: 10.h),
            child: CircleAvatar(
              backgroundColor: white,
              child: IconButton(
                onPressed: () => _showDeleteConfirmationPopup(
                    context, widget.model?.id ?? 0),
                icon: Icon(
                  Icons.delete,
                  color: red,
                  size: 22.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  removePhoto(int photoId, BuildContext context) async {
    final result = await context.read<ActionPhotoCubit>().removePhoto(
          photoId: photoId,
        );
    if (!result.hasError) {
      Navigator.pop(context);
      refreshIndicatorPhotosKey.currentState?.show();
    }
  }

  void _showDeleteConfirmationPopup(BuildContext context, int photoId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (_) => ActionPhotoCubit(supVisitsUC: GetIt.I<SupVisitsUC>()),
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Delete Confirmation'),
              content: const Text('Are you sure ?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                AppBlocConsumer<ActionPhotoCubit, BaseResponse<SuccessResponseModel?>>(
                  onSuccessBuilder: (context, state) {
                    final isLoading = state.status == RequestStatus.loading;
                    return isLoading
                        ? const Text(
                            'Deleting...',
                            style: TextStyle(
                              color: greyColor,
                            ),
                          )
                        : TextButton(
                            child: const Text('Delete'),
                            onPressed: () {
                              removePhoto(photoId, context);
                            },
                          );
                  },
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
