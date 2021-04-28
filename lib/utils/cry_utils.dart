import 'package:flutter/material.dart';

class CryUtils {
  static GlobalKey<NavigatorState> navigatorKey;
  static OverlayEntry loadingOE;

  static void loading({bool tapClose = false}) {
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
    loadingOE.remove();
  }
}
