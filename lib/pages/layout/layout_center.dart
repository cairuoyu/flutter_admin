import 'package:flutter/material.dart';
import 'package:flutter_admin/common/routes.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/pages/common/keep_alive_wrapper.dart';
import 'package:flutter_admin/pages/common/page_404.dart';
import 'package:flutter_admin/pages/layout/layout_controller.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:get/get.dart';

class LayoutCenter extends StatefulWidget {
  LayoutCenter({Key key, this.initPage}) : super(key: key);
  final Menu initPage;

  @override
  LayoutCenterState createState() => LayoutCenterState();
}

class LayoutCenterState extends State<LayoutCenter> with TickerProviderStateMixin {
  Container content = Container();
  List<Widget> pages;
  LayoutController layoutController = Get.find();

  @override
  void initState() {
    if (widget.initPage != null) {
      WidgetsBinding.instance.addPostFrameCallback((c) {
        Utils.openTab(widget.initPage);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = layoutController.tabController;
    var menuOpened = layoutController.menuOpened;
    var length = menuOpened.length;
    if (length == 0) {
      return Container();
    }
    int index = menuOpened.indexWhere((note) => note.id == layoutController.currentOpenedMenuId);
    pages = menuOpened.map((Menu menu) {
      var page = layoutRoutesData[menu.url];
      return KeepAliveWrapper(child: page ?? Page404());
    }).toList();

    int tabIndex = tabController?.index ?? 0;
    int initialIndex = tabIndex > length - 1 ? length - 1 : tabIndex;
    tabController?.dispose();
    tabController = TabController(vsync: this, length: pages.length, initialIndex: initialIndex);
    layoutController.tabController = tabController;
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        layoutController.updateCurrentOpendMenuId(menuOpened[tabController.index].id);
      }
    });

    TabBar tabBar = TabBar(
      controller: tabController,
      isScrollable: true,
      indicator: const UnderlineTabIndicator(),
      tabs: menuOpened.map<Tab>((Menu menu) {
        return Tab(
          child: Row(
            children: <Widget>[
              Text(Utils.isLocalEn(context) ? menu.nameEn ?? '' : menu.name ?? ''),
              SizedBox(width: 3),
              InkWell(
                child: Icon(Icons.close, size: 10),
                onTap: () => Utils.closeTab(menuOpened.indexOf(menu)),
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

    tabController.animateTo(index);
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
