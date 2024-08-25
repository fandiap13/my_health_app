import 'package:ble_client/constants.dart';
import 'package:ble_client/enums.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtils {
  static scaffoldMessage(
      {required String message, required BuildContext context}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: kGreenColor,
      elevation: 0,
      dismissDirection: DismissDirection.up,
      duration: const Duration(seconds: 5),
      // behavior: SnackBarBehavior.floating,
      // margin: EdgeInsets.only(
      //     bottom: MediaQuery.of(context).size.height - 150,
      //     left: 10,
      //     right: 10),
      action: SnackBarAction(
        label: 'Dismiss',
        disabledTextColor: Colors.white,
        textColor: Colors.white,
        onPressed: () {
          //Do whatever you want
          ScaffoldMessenger.of(context)
              .hideCurrentSnackBar(); // Menutup Snackbar
        },
      ),
    ));
  }

  static void toastMessage({required String message, Color? bgColor}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor ?? kGreenColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static confirmDialog(
      {required BuildContext context,
      String? title,
      String? message,
      required VoidCallback action}) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          title: Text(
            title ?? "",
            textAlign: TextAlign.center,
          ),
          content: Text(
            message ?? "",
            textAlign: TextAlign.center,
          ),
          //     Navigator.of(context).pop();
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll(kBlueColor),
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.symmetric(vertical: 12)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)))),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          action();
                        },
                        child: const Text(
                          "Ok",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll(kBlueColor),
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.symmetric(vertical: 12)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Batal",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static PresentaseValueState presentaseKesehatanValue(
      {required double value, required String pengecekanKesehatan}) {
    // if (pengecekanKesehatan.toLowerCase() == "saturasi oksigen darah") {
    if (pengecekanKesehatan.toLowerCase() == "saturasi oksigen") {
      if (value >= 95 && value <= 100) {
        return PresentaseValueState.NORMAL;
      } else if (value >= 90 && value <= 94) {
        return PresentaseValueState.LOW;
      } else {
        return PresentaseValueState.HIGH;
      }
    } else if (pengecekanKesehatan.toLowerCase() == "detak jantung") {
      if (value < 60) {
        return PresentaseValueState.LOW;
      } else if (value >= 60 && value <= 100) {
        return PresentaseValueState.NORMAL;
      } else {
        return PresentaseValueState.HIGH;
      }
    } else {
      if (value < 36.5) {
        return PresentaseValueState.LOW;
      } else if (value >= 36.5 && value <= 37.5) {
        return PresentaseValueState.NORMAL;
      } else {
        return PresentaseValueState.HIGH;
      }
    }
  }
}
