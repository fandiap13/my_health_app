import 'package:ble_client/constants.dart';
import 'package:flutter/material.dart';

class AppUtils {
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
          content: Text(message ?? ""),
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
}
