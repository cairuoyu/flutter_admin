import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/common/routes.dart';
import 'package:flutter_admin/models/tab_page.dart';
import 'package:flutter_admin/pages/common/keep_alive_wrapper.dart';
import 'package:flutter_admin/pages/layout/layout_controller.dart';
import 'package:flutter_admin/utils/store_util.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:get/get.dart';

class LayoutCenter extends StatefulWidget {
  LayoutCenter({Key? key}) : super(key: key);

  @override
  LayoutCenterState createState() => LayoutCenterState();
}

class LayoutCenterState extends State<LayoutCenter> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('layoutCenter--build');
    var openedTabPageList = StoreUtil.readOpenedTabPageList();
    var currentOpenedTabPageId = StoreUtil.readCurrentOpenedTabPageId();
    int currentIndex = openedTabPageList.indexWhere((note) => note!.id == currentOpenedTabPageId);

    var tabBar = Row(
      children: openedTabPageList.map((TabPage? tabPage) {
        var tabContent = Row(
          children: <Widget>[
            TextButton(
              onPressed: () {
                StoreUtil.writeCurrentOpenedTabPageId(tabPage!.id);
                setState(() {});
              },
              child: Text(Utils.isLocalEn(context) ? tabPage!.nameEn ?? '' : tabPage!.name ?? ''),
              style: ButtonStyle(foregroundColor: MaterialStateProperty.all(currentOpenedTabPageId == tabPage.id ? Colors.red : Colors.yellow)),
            ),
            if (!Routes.defaultTabPage.contains(tabPage))
              Material(
                type: MaterialType.transparency,
                child: SizedBox(
                  width: 25,
                  child: IconButton(
                    iconSize: 10,
                    splashRadius: 10,
                    onPressed: () => Utils.closeTab(tabPage),
                    icon: Icon(Icons.close),
                  ),
                ),
              )
          ],
        );
        return tabContent;
      }).toList(),
    );

    var content = Container(
      child: Expanded(
        child: IndexedStack(
          index: currentIndex,
          children: openedTabPageList.map((TabPage? tabPage) {
            var page = tabPage!.url != null ? Routes.layoutPagesMap[tabPage.url!] ?? Container() : tabPage.widget ?? Container();
            return KeepAliveWrapper(child: page,key: Key('pageid ${tabPage.id}'),);
            // return page;
          }).toList(),
        ),
      ),
    );

    LayoutController layoutController = Get.find();
    var result = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(child: tabBar),
                IconButton(
                  onPressed: () => layoutController.toggleMaximize(),
                  icon: Icon(layoutController.isMaximize ? Icons.close_fullscreen : Icons.open_in_full),
                  iconSize: 20,
                  color: Colors.white,
                )
              ],
            ),
            decoration: BoxDecoration(
              color: context.theme.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0,
                )
              ],
            ),
          ),
          content,
        ],
      ),
    );
    return result;
  }
}
