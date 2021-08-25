/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/common/routes.dart';
import 'package:flutter_admin/constants/enum.dart';
import 'package:flutter_admin/models/tab_page.dart';
import 'package:flutter_admin/pages/common/IndexedStackLazy.dart';
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
    var openedTabPageList = StoreUtil.readOpenedTabPageList();
    if(openedTabPageList.length==0){
      return Container();
    }
    var currentOpenedTabPageId = StoreUtil.readCurrentOpenedTabPageId();
    int currentIndex = openedTabPageList.indexWhere((note) => note!.id == currentOpenedTabPageId);
    var tabController = TabController(vsync: this, length: openedTabPageList.length, initialIndex: currentIndex);
    var defaultTabs = StoreUtil.getDefaultTabs();

    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        StoreUtil.writeCurrentOpenedTabPageId(openedTabPageList[tabController.index]!.id);
        setState(() {});
      }
    });

    TabBar tabBar = TabBar(
      controller: tabController,
      isScrollable: true,
      indicator: const UnderlineTabIndicator(),
      tabs: openedTabPageList.map<Tab>((TabPage? tabPage) {
        var tabContent = Row(
          children: <Widget>[
            Text(Utils.isLocalEn(context) ? tabPage!.nameEn ?? '' : tabPage!.name ?? ''),
            if (!defaultTabs.contains(tabPage))
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
        return Tab(
          child: CryMenu(
            child: tabContent,
            onSelected: (dynamic v) {
              switch (v) {
                case TabMenuOption.close:
                  Utils.closeTab(tabPage);
                  break;
                case TabMenuOption.closeAll:
                  Utils.closeAllTab();
                  break;
                case TabMenuOption.closeOthers:
                  Utils.closeOtherTab(tabPage);
                  break;
                case TabMenuOption.closeAllToTheRight:
                  Utils.closeAllToTheRightTab(tabPage);
                  break;
                case TabMenuOption.closeAllToTheLeft:
                  Utils.closeAllToTheLeftTab(tabPage);
                  break;
              }
            },
            itemBuilder: (context) => <PopupMenuEntry<TabMenuOption>>[
              if (!defaultTabs.contains(tabPage))
                PopupMenuItem(
                  value: TabMenuOption.close,
                  child: ListTile(
                    title: Text('Close'),
                  ),
                ),
              PopupMenuItem(
                value: TabMenuOption.closeAll,
                child: ListTile(
                  title: Text('Close All'),
                ),
              ),
              PopupMenuItem(
                value: TabMenuOption.closeOthers,
                child: ListTile(
                  title: Text('Close Others'),
                ),
              ),
              PopupMenuItem(
                value: TabMenuOption.closeAllToTheRight,
                child: ListTile(
                  title: Text('Close All to the Right'),
                ),
              ),
              PopupMenuItem(
                value: TabMenuOption.closeAllToTheLeft,
                child: ListTile(
                  title: Text('Close All to the Left'),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );

    var content = Container(
      child: Expanded(
        child: IndexedStackLazy(
          index: currentIndex,
          children: openedTabPageList.map((TabPage? tabPage) {
            var page = tabPage!.url != null ? Routes.layoutPagesMap[tabPage.url!] ?? Container() : tabPage.widget ?? Container();
            return KeyedSubtree(
              child: page,
              key: Key('page-${tabPage.id}'),
            );
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
