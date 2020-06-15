import 'package:flutter/material.dart';
import 'package:flutter_admin/components/cryDialog.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static toPortal(BuildContext context,String message,String buttonText,String url) {
    cryAlert(
      context,
      Container(
        height: 100,
        child: Column(
          children: [
            Text(message),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              color: Colors.lightBlue,
              child: Text(buttonText),
              onPressed: () {
                Utils.launchURL(url);
              },
            ),
          ],
        ),
      ),
    );
  }
}
