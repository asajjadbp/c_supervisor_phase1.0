import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/utilities/snackbar_presenter.dart';

import '/flutter_core.dart';

/// Displays the PickerActionDialog which prompts the user to select the source of the file(s)/image(s)
/// [actions] list of actions that are provided to be shown in the dialog (e.g.: [CameraPickerAction])
/// Afterwards it handles the result of the selection by the provided [onPick]
///
/// This feature needs to be tested on a real iOS device because otherwise it throws
/// Unhandled Exception: PlatformException(multiple_request, Cancelled by a second request, null, null)
/// https://github.com/flutter/flutter/issues/70436
Future<List<XFile>?> displayPickerActionDialog(
    {required BuildContext context,
    required String title,
    required List<PickerAction> actions,
    String? permissionDeniedMessage,
    Function(List<XFile> files, BuildContext context)? onPick,
    int currentSelectedFilesCount = 0}) async {
  return showDialog<List<XFile>?>(
      barrierColor: context.colorScheme.primary.withOpacity(.9),
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text(
            /// TODO(bug): Localization
            title,
            textAlign: TextAlign.center,
            style: context.textTheme.headlineMedium?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeightExt.heavy,
              letterSpacing: .75,
            ),
          ),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: actions.map((action) {
                return ElevatedButton(
                  child: Text(
                    action.properties.actionName,
                    style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeightExt.medium,
                        letterSpacing: .86,
                        color: context.theme.scaffoldBackgroundColor),
                  ),
                  onPressed: () async {
                    try {
                      final picked = await action.retrieveMediaFilesFromSource(
                          currentSelectedFilesCount);
                      onPick?.call(picked, context);
                      Navigator.of(ctx).pop(picked);
                    } catch (e) {
                      log("Error Selecting: ${e.toString()}",
                          name: 'File Picker Selection');

                      /// only show the error if it from type of [FilePickerException]
                      if (e is FilePickerException) {
                        context.showNotice(Notice(message: e.toString()));
                      } else if (e is PlatformException) {
                        context.showNotice(Notice(
                            message: permissionDeniedMessage ??
                                "You can not use this Feature without allowing this Permission\nPlease turn on permissions at [Setting] > [Permission]"));
                      }
                      Navigator.of(ctx).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                );
              }).toList()),
        );
      });
}
