import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/data/models/rate/rate_model.dart';
import 'package:c_supervisor/domain/use_cases/add_rate_uc.dart';
import 'package:c_supervisor/ui/bloc/index.dart';
import 'package:networking/client/networking_models/index.dart';

class RateCubit extends BaseAppCubit<EmptyModel?> {
  final RateUC rateUC;

  RateCubit({
    required this.rateUC,
  });

  Future<BaseResponse<EmptyModel?>> addRate({
    required RateModel rateModel,
  }) async {
    return await networkCall(
      () => rateUC.addRate(rateModel),
    );
  }
}
