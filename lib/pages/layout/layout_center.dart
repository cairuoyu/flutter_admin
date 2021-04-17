import 'package:cry/cry_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/common/routes.dart';
import 'package:flutter_admin/constants/enum.dart';
import 'package:flutter_admin/models/tab_page.dart';
import 'package:flutter_admin/pages/common/keep_alive_wrapper.dart';
import 'package:flutter_admin/pages/layout/layout_controller.dart';
import 'package:flutter_admin/utils/store_util.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:get/get.dart';

class LayoutCenter extends StatefulWidget {
  LayoutCenter({Key key, this.initPage}) : super(key: key);
  final TabPage initPage;

  @override
  LayoutCenterState createState() => LayoutCenterState();
}

class LayoutCenterState extends State<LayoutCenter> with TickerProviderStateMixin {
  Container content = Container();
  List<Widget> pages;
  LayoutController layoutController = Get.find();

  @override
  void initState() {
    if (widget.initPage != null && StoreUtil.readCurrentOpenedTabPageId() == null) {
      WidgetsBinding.instance.addPostFrameCallback((c) {
        Utils.openTab(widget.initPage);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = layoutController.tabController;
    var openedTabPageList = StoreUtil.readOpenedTabPageList();
    var length = openedTabPageList.length;
    if (length == 0) {
      return Container();
    }
    var currentOpenedTabPageId = StoreUtil.readCurrentOpenedTabPageId();
    int index = openedTabPageList.indexWhere((note) => note.id == currentOpenedTabPageId);
    pages = openedTabPageList.map((TabPage tabPage) {
      var page = tabPage.url != null ? Routes.layoutPagesMap[tabPage.url] ?? Container() : tabPage.widget ?? Container();
      return KeepAliveWrapper(child: page);
    }).toList();

    int tabIndex = tabController?.index ?? 0;
    int initialIndex = tabIndex > length - 1 ? length - 1 : tabIndex;
    tabController?.dispose();
    tabController = TabController(vsync: this, length: pages.length, initialIndex: initialIndex);
    tabController.animateTo(index);
    layoutController.tabController = tabController;
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        StoreUtil.writeCurrentOpenedTabPageId(openedTabPageList[tabController.index].id);
        layoutController.update();
      }
    });

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
          children: pages,
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
