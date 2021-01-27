import 'package:flutter/material.dart';
import 'package:flutter_admin/common/base_state.dart';
import 'package:flutter_admin/common/routes.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/pages/common/page_404.dart';
import 'package:flutter_admin/utils/store_util.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:get/get.dart';

class LayoutCenter extends StatefulWidget {
  LayoutCenter({Key key, this.initPage}) : super(key: key);
  final Menu initPage;

  @override
  LayoutCenterState createState() => LayoutCenterState();
}

class LayoutCenterState extends BaseState<LayoutCenter> with TickerProviderStateMixin {
  TabController tabController;
  Container content = Container();

  @override
  void initState() {
    if (widget.initPage != null) {
      openPage(widget.initPage);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (StoreUtil.instance.menuOpened.length == 0) {
      return Container();
    }

    int index = StoreUtil.instance.menuOpened.indexWhere((note) => note.id == StoreUtil.instance.currentOpenedMenuId);
    List<Widget> children = StoreUtil.instance.menuOpened.map((menu) {
      return menu.url != null && layoutRoutesData[menu.url] != null ? layoutRoutesData[menu.url] : Page404();
    }).toList();
    tabController = TabController(vsync: this, length: children.length);

    var body = TabBarView(
      controller: tabController,
      children: children,
    );

    content = Container(
      child: Expanded(
        child: body,
      ),
    );
    tabController.animateTo(index);

    TabBar tabBar = TabBar(
      controller: tabController,
      isScrollable: true,
      indicator: const UnderlineTabIndicator(),
      tabs: StoreUtil.instance.menuOpened.map<Tab>((Menu menu) {
        return Tab(
          child: Row(
            children: <Widget>[
              Text(Utils.isLocalEn(context) ? menu.nameEn ?? '' : menu.name ?? ''),
              SizedBox(width: 3),
              InkWell(
                child: Icon(Icons.close, size: 10),
                onTap: () => _closePage(menu),
              ),
            ],
          ),
        );
      }).toList(),
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

  _closePage(menu) {
    StoreUtil.instance.menuOpened.remove(menu);
    var length = StoreUtil.instance.menuOpened.length;
    StoreUtil.instance.currentOpenedMenuId = length > 0 ? StoreUtil.instance.menuOpened[length - 1].id : null;
    setState(() {});
  }

  openPage(Menu menu) {
    StoreUtil.instance.currentOpenedMenuId = menu.id;
    int index = StoreUtil.instance.menuOpened.indexWhere((note) => note.id == menu.id);
    if (index > -1) {
      tabController?.animateTo(index);
      return;
    }
    StoreUtil.instance.menuOpened.add(menu);
    setState(() {});
  }
}
