import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AppUtils {
  showSnackBar({String message = ""}) {
    Fluttertoast.showToast(
        msg: message, timeInSecForIosWeb: 3, gravity: ToastGravity.CENTER);
  }
}

extension StringExtension on String {
  get toMDate {
    try {
      if (this != "" && this != "null") {
        DateTime parseDate = DateFormat("dd-MM-yyyy").parse(this);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat('dd-MMM-yyyy');
        return outputFormat.format(inputDate);
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  get toDate {
    try {
      if (this != "" && this != "null") {
        DateTime parseDate = DateFormat("yyyy-MM-dd").parse(this);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat('dd-MM-yyyy');
        return outputFormat.format(inputDate);
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  get toDateWithTime {
    try {
      if (this != "" && this != "null") {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(this);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat('dd MMM yyyy hh:mm a');
        return outputFormat.format(inputDate);
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  get toDateTime {
    try {
      if (this != "" && this != "null") {
        DateTime parseDate =
            DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(this);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat('dd MMM yyyy hh:mm a');
        return outputFormat.format(inputDate);
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  get toDateDay {
    try {
      if (this != "" && this != "null") {
        DateTime parseDate = DateFormat("yyyy-MM-dd").parse(this);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat('EEEE');
        return outputFormat.format(inputDate);
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  bool get isNullOrEmpty {
    bool _hasSpace = RegExp(r'\s').hasMatch(this);
    //  bool _hasSpace = this.contains(' ');
    return this == "null" || isEmpty || _hasSpace;
  }
}
