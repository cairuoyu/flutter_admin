import 'package:flutter/material.dart';
import 'package:flutter_admin/data/data1.dart';
import 'package:flutter_admin/utils/globalUtil.dart';
import 'package:flutter_admin/vo/pageVO.dart';

class Layout1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Layout1State();
}

class Layout1State extends State with TickerProviderStateMixin {
  List<PageVO> pageVoAll;
  List<PageVO> pageVoOpened;
  TabController tabController;
  Container content;
  int length;
  bool expandMenu = true;
  @override
  void initState() {
    super.initState();
    pageVoAll = testPageVOAll;
    pageVoOpened = <PageVO>[pageVoAll[0]];
    length = pageVoOpened.length;
    tabController = TabController(vsync: this, length: length);
    if (pageVoOpened.length > 0) {
      loadPage(pageVoOpened[0]);
    }
  }

  loadPage(page) {
    content = Container(
      child: Expanded(
        child: page.widget != null ? page.widget : Center(child: Text('404')),
      ),
    );
    int index = pageVoOpened.indexWhere((note) => note.id == page.id);
    if (index > -1) {
      tabController.index = index;
    } else {
      pageVoOpened.add(page);
      tabController = TabController(vsync: this, length: ++length);
      tabController.index = length - 1;
    }
    setState(() {});
  }

  List<Widget> genListTile(data) {
    List<Widget> listTileList = data.map<Widget>((PageVO page) {
      Text title = Text(expandMenu ? page.title : '');
      if (page.children != null && page.children.length > 0) {
        return ExpansionTile(
          leading: Icon(expandMenu ? page.icon : null),
          backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
          children: genListTile(page.children),
          title: title,
        );
      } else {
        return ListTile(
          leading: Icon(page.icon),
          title: title,
          onTap: () => loadPage(page),
        );
      }
    }).toList();
    return listTileList;
  }

  @override
  Widget build(BuildContext context) {
    

    ListTile menuHeader = ListTile(
      title: Icon(Icons.menu),
      onTap: () {
        expandMenu = !expandMenu;
        setState(() {});
      },
    );
    List<Widget> menuBody = genListTile(pageVoAll);
    ListView menu = ListView(children: [menuHeader, ...menuBody]);
    TabBar tabBar = TabBar(
      onTap: (index) => loadPage(pageVoOpened[index]),
      controller: tabController,
      isScrollable: true,
      indicator: getIndicator(),
      tabs: pageVoOpened.map<Tab>((PageVO page) {
        return Tab(
          text: page.title,
        );
      }).toList(),
    );

    Row body = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: expandMenu ? 300 : 60,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[50],
              // border: Border(right: BorderSide(color: Colors.black)),
            ),
            child: menu,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: tabBar,
                      
                      decoration: BoxDecoration(
                        color: Colors.blue,
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
        ),
      ],
    );
    Scaffold subWidget = Scaffold(
        appBar: AppBar(
          
          title: Text("FLUTTER_ADMIN"),
          actions: <Widget>[
            OutlineButton.icon(
              label: Text("退出"),
              onPressed: () {
                logout();
              },
              icon: Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: body);
    return subWidget;
  }

  logout() {
    GlobalUtil.token = null;
    Navigator.of(context, rootNavigator: true).pop();
  }

  getIndicator() {
    return const UnderlineTabIndicator();
  }
}
