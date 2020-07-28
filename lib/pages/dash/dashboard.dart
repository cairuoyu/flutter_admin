import 'package:flutter/material.dart';
import 'package:flutter_admin/utils/adaptiveUtil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_admin/charts/SimpleSeriesLegend.dart';
import 'package:flutter_admin/data/data1.dart';
import 'package:flutter_admin/vo/listTileVO.dart';
import 'package:intl/intl.dart';
import '../../generated/l10n.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    var a = Column(
      children: <Widget>[
        _getOverview(context, isDesktop),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildTitledContainer(
              S.of(context).dashTotal,
              child: Container(
                height: 200,
                child: SimpleSeriesLegend.withSampleData(),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _getAList(Intl.defaultLocale == 'en' ? todoList_en : todoList,
                        flex: 3, title: S.of(context).dashToDoList),
                    SizedBox(width: 16),
                    _getAList(linkList, flex: 1, title: S.of(context).dashTopLinks),
                  ],
                )
              : Container(
                  width: double.infinity,
                  height: 850,
                  child: Column(
                    children: <Widget>[
                      _getAList(Intl.defaultLocale == 'en' ? todoList_en : todoList,
                          flex: 1, title: S.of(context).dashToDoList),
                      _getAList(linkList, flex: 1, title: S.of(context).dashTopLinks),
                    ],
                  ),
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

  _getABox(title, subtitle, color, icon) {
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

  Container _buildTitledContainer(String title, {Widget child, double height}) {
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

  _getAList(List<ListTileVO> list, {title, flex = 1}) {
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

  _getASizedBox(isDesktop) {
    return SizedBox(
      width: isDesktop ? 20 : 0,
      height: isDesktop ? 0 : 20,
    );
  }

  _getOverview(context, isDesktop) {
    var boxList = <Widget>[
      _getABox('190', S.of(context).dashUpcoming, Colors.red, Icon(FontAwesomeIcons.list)),
      _getASizedBox(isDesktop),
      _getABox('33', S.of(context).dashInProgress, Colors.blue, Icon(FontAwesomeIcons.footballBall)),
      _getASizedBox(isDesktop),
      _getABox('58', S.of(context).dashDone, Colors.green, Icon(FontAwesomeIcons.wind)),
      _getASizedBox(isDesktop),
      _getABox('1024', S.of(context).dashFinish, Colors.black38, Icon(FontAwesomeIcons.wallet)),
    ];

    if (isDesktop) {
      return Container(
        padding: const EdgeInsets.all(18.0),
        child: Row(children: boxList),
      );
    } else {
      return Container(
        width: double.infinity,
        height: 500,
        padding: const EdgeInsets.all(18.0),
        child: Column(children: boxList),
      );
    }
  }
}
