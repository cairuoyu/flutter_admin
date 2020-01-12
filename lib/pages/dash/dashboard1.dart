import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_admin/charts/SimpleSeriesLegend.dart';
import 'package:flutter_admin/data/data1.dart';
import 'package:flutter_admin/vo/listTileVO.dart';

class Dashboard1 extends StatelessWidget {
  const Dashboard1({Key key}) : super(key: key);

  getABox(title, subtitle, color, icon) {
    final TextStyle whiteText = TextStyle(color: Colors.white);
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: color,
          boxShadow: [
            BoxShadow(color: Colors.black26, offset: Offset(2.0, 2.0), blurRadius: 4.0),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              trailing: icon,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                subtitle,
                style: whiteText,
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildTitledContainer(String title, {Widget child, double height}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black26, offset: Offset(2.0, 2.0), blurRadius: 4.0),
        ],
        
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          if (child != null) ...[const SizedBox(height: 10.0), child]
        ],
      ),
    );
  }

  getAList(List<ListTileVO> list, {title, flex = 1}) {
    var header = Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black26, offset: Offset(2.0, 2.0), blurRadius: 4.0),
        ],
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: ListTile(
        dense: true,
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue),
        ),
        trailing: Icon(FontAwesomeIcons.alignRight, color: Colors.blue),
      ),
    );
    var body = list.map((v) {
      return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black26, offset: Offset(2.0, 2.0), blurRadius: 4.0),
          ],
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black12)),
        ),
        child: ListTile(
          dense: true,
          title: Text(v.title),
          trailing: v.trailing == null ? null : Text(v.trailing),
        ),
      );
    });
    var b = Expanded(
      flex: flex,
      child: Container(
        height: (list.length + 1) * 50.0,
        child: ListView(
          children: <Widget>[header, ...body],
        ),
      ),
    );
    return b;
  }

  @override
  Widget build(BuildContext context) {
    var a = Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: <Widget>[
              getABox('190', '待办', Colors.red, Icon(FontAwesomeIcons.list)),
              SizedBox(width: 20),
              getABox('33', '在办', Colors.blue, Icon(FontAwesomeIcons.footballBall)),
              SizedBox(width: 20),
              getABox('58', '已办', Colors.green, Icon(FontAwesomeIcons.wind)),
              SizedBox(width: 20),
              getABox('1024', '办结', Colors.black38, Icon(FontAwesomeIcons.wallet)),
            ],
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: buildTitledContainer(
              "数量统计",
              child: Container(
                height: 200,
                child: SimpleSeriesLegend.withSampleData(),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getAList(todoList, flex: 3, title: '待办列表'),
              SizedBox(width: 16),
              getAList(linkList, flex: 1, title: "常用链接"),
            ],
          ),
        ),
      ],
    );
    var b = CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: a,
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: b,
    );
  }
}
