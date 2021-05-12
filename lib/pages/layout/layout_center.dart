import 'package:cry/cry_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/common/routes.dart';
import 'package:flutter_admin/constants/enum.dart';
import 'package:flutter_admin/models/tab_page.dart';
import 'package:flutter_admin/pages/common/keep_alive_wrapper.dart';
import 'package:flutter_admin/utils/store_util.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:get/get.dart';

class LayoutCenter extends StatefulWidget {
  LayoutCenter({Key key, this.mainPage}) : super(key: key);
  final String mainPage;

  @override
  LayoutCenterState createState() => LayoutCenterState();
}

class LayoutCenterState extends State<LayoutCenter> with TickerProviderStateMixin {
  Container content = Container();
  TabController tabController;

  @override
  void initState() {
    if (widget.mainPage != null && StoreUtil.readCurrentOpenedTabPageId() == null) {
      WidgetsBinding.instance.addPostFrameCallback((c) {
        Utils.openTab(widget.mainPage);
      });
    }

    var openedTabPageList = StoreUtil.readOpenedTabPageList();
    if (openedTabPageList.isEmpty) {
      return;
    }
    var currentOpenedTabPageId = StoreUtil.readCurrentOpenedTabPageId();
    int initialIndex = openedTabPageList.indexWhere((note) => note.id == currentOpenedTabPageId);
    tabController = TabController(vsync: this, length: openedTabPageList.length, initialIndex: initialIndex);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        StoreUtil.writeCurrentOpenedTabPageId(openedTabPageList[tabController.index].id);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var openedTabPageList = StoreUtil.readOpenedTabPageList();
    if (openedTabPageList.isEmpty) {
      return Container();
    }
    TabBar tabBar = TabBar(
      controller: tabController,
      isScrollable: true,
      indicator: const UnderlineTabIndicator(),
      tabs: openedTabPageList.map<Tab>((TabPage tabPage) {
        var tabContent = Row(
          children: <Widget>[
            Text(Utils.isLocalEn(context) ? tabPage.nameEn ?? '' : tabPage.name ?? ''),
            SizedBox(width: 3),
            InkWell(
              child: Icon(Icons.close, size: 10),
              onTap: () => Utils.closeTab(tabPage),
            ),
          ],
        );
        return Tab(
          child: CryMenu(
            child: tabContent,
            onSelected: (v) {
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

    content = Container(
      child: Expanded(
        child: TabBarView(
          controller: tabController,
          children: openedTabPageList.map((TabPage tabPage) {
            var page = tabPage.url != null ? Routes.layoutPagesMap[tabPage.url] ?? Container() : tabPage.widget ?? Container();
            return KeepAliveWrapper(child: page);
          }).toList(),
        ),
      ),
    );

    var result = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: tabBar,
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
              ),
            ],
          ),
          content,
        ],
      ),
    );
    return result;
  }
}
