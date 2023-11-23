import 'package:c_supervisor/ui/index.dart';

class AppDialog {
  final String title;
  final String confirmTitle;
  final String? cancelTitle;
  final Function()? onConfirmClicked;
  final Function()? onCancelClicked;

  AppDialog({
    required this.title,
    required this.confirmTitle,
    this.cancelTitle,
    this.onConfirmClicked,
    this.onCancelClicked,
  });

  Future<void> showAppDialog(
    BuildContext parentContext,
    Widget dialogChild,
  ) async {
    return showDialog<void>(
      context: parentContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return WillPopScope(
          /// Prevent exiting the app on back button press
          onWillPop: () async {
            return false;
          },
          child: GestureDetector(
            onTap: () {
              /// Prevent exiting the app on tap outside the dialog
              return;
            },
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              contentPadding: EdgeInsets.zero,
              title: Text(
                title,
                style: const TextStyle(color: blue),
              ),
              content: SizedBox(
                height: 250.0,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(child: dialogChild),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: onCancelClicked,
                  child: Text(cancelTitle ?? ''),
                ),
                TextButton(
                  onPressed: onConfirmClicked,
                  child: Text(confirmTitle),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
