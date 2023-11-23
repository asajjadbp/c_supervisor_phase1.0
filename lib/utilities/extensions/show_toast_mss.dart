import 'package:c_supervisor/ui/index.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension ToastExtension on String {
  void showToast({
    Toast? toastLength,
    ToastGravity? gravity,
    Color? backgroundColor,
    Color? textColor,
  }) {
    Fluttertoast.showToast(
      msg: this,
      toastLength: toastLength ?? Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor ?? greyColor,
      textColor: textColor ?? white,
      fontSize: 16.0.sp,
    );
  }
}

extension ScaffoldMessengerExtension on String {
  void showScaffoldMessenger(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(this),
      ),
    );
  }
}

extension ShowDialogHelper on String {
  Future<void> showMyDialogHelper(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              Expanded(
                child: Text(
                  this,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
