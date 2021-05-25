import 'package:flutter/material.dart';
import 'package:cry/cry.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/user_info.dart';
import 'package:flutter_admin/utils/utils.dart';

class LayoutAppBar extends AppBar {
  LayoutAppBar(
    BuildContext context, {
    Key? key,
    int? type,
    openSetting,
    openMenu,
    dispose,
    required UserInfo userInfo,
  }) : super(
          key: key,
          automaticallyImplyLeading: false,
          leading: !Utils.isMenuDisplayTypeDrawer(context)
              ? Tooltip(
                  message: 'Home',
                  child: IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () {
                      Utils.launchURL('http://www.cairuoyu.com');
                    },
                  ))
              : Tooltip(
                  message: 'Menu',
                  child: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      openMenu();
                    },
                  )),
          title: Text("FLUTTER_ADMIN"),
          actions: <Widget>[
            Tooltip(
              message: 'Setting',
              child: IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  openSetting();
                },
              ),
            ),
            // Tooltip(
            //   message: type == 1 ? S.of(context).noRoutingMode : S.of(context).routingMode,
            //   child: IconButton(
            //     icon: Icon(Icons.link),
            //     onPressed: () {
            //       Navigator.pushNamed(context, type == 1 ? '/layoutNoRoutes' : '/');
            //     },
            //   ),
            // ),
            Tooltip(
              message: 'Code',
              child: IconButton(
                icon: Icon(Icons.code),
                onPressed: () {
                  Utils.launchURL("https://github.com/cairuoyu/flutter_admin");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton(
                tooltip: S.of(context)!.information,
                onSelected: (dynamic v) {
                  if (v == 'info') {
                    Utils.openTab('/userInfoMine');
                  } else if (v == 'logout') {
                    // dispose();
                    Utils.logout();
                    Cry.pushNamedAndRemove('/login');
                  }
                },
                child: Align(
                  child: userInfo.avatarUrl == null
                      ? Icon(Icons.person)
                      : CircleAvatar(
                          backgroundImage: NetworkImage(userInfo.avatarUrl!),
                          radius: 12.0,
                        ),
                ),
                itemBuilder: (context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'info',
                    child: ListTile(
                      leading: const Icon(Icons.info),
                      title: Text(S.of(context)!.myInformation),
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: ListTile(
                      leading: const Icon(Icons.logout),
                      title: Text(S.of(context)!.logout),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
}
