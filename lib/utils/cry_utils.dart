import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CryUtils {
  static GlobalKey<NavigatorState> navigatorKey;
  static OverlayEntry loadingOE;

  static get context => navigatorKey.currentContext;

  static void message(String message, {int duration = 2}) {
    if (!kIsWeb && Platform.isWindows) {
      ScaffoldMessenger.of(CryUtils.context).hideCurrentSnackBar();
      ScaffoldMessenger.of(CryUtils.context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    } else {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  static void loading({bool tapClose = false}) {
    if (loadingOE != null) {
      loadingOE.remove();
    }
    var child = Container(
        child: tapClose
            ? InkWell(
                child: Center(child: CircularProgressIndicator()),
                onTap: () => loaded(),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
        decoration: new BoxDecoration(
          color: Colors.transparent,
        ));
    loadingOE = OverlayEntry(builder: (c) => child);
    Overlay.of(navigatorKey.currentContext).insert(loadingOE);
  }

  static void loaded() {
    if (loadingOE == null) {
      return;
    }
    loadingOE.remove();
    loadingOE = null;
  }
}
