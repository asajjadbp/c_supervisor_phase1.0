import 'package:c_supervisor/domain/use_cases/index.dart';
import 'package:c_supervisor/ui/bloc/upload_image_cubit.dart';
import 'package:c_supervisor/ui/pages/check_in/checkin_content.dart';
import 'package:c_supervisor/ui/pages/check_in/cubit/check_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CheckInPage extends StatelessWidget {
  const CheckInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CheckInCubit>(
          create: (context) => CheckInCubit(GetIt.I<UserCheckInUC>())),
      BlocProvider<UploadImageCubit>(
          create: (context) => UploadImageCubit(
                uploadImageUC: GetIt.I<UploadImageUC>(),
              )),
    ], child: const CheckInContent());
  }
}
