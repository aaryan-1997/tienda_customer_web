import 'package:fluttertoast/fluttertoast.dart';

class AppUtils {
  showSnackBar({String message = ""}) {
    Fluttertoast.showToast(
        msg: message, timeInSecForIosWeb: 3, gravity: ToastGravity.CENTER);
  }
}
