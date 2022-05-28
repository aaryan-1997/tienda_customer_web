import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

void commonAlert(BuildContext context, String message) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return Theme(
          data: ThemeData.light(),
          child: Builder(builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                'Tienda',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              content: Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                )
              ],
            );
          }),
        );
      });
}

void commonAlertWithNavigation(
    {required BuildContext context,
    required String message,
    required Function() okBtnFunction}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: AppColor.appColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(20),
                  child: Text(
                    'Tienda',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(20),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Raleway'),
                  ),
                ),
                InkWell(
                  onTap: () {
                    okBtnFunction();
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: Text(
                      'Ok',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
