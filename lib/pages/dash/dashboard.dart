/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/utils/adaptive_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/pages/dash/task_statistical_chart.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_admin/data/data_dashboard.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                _getOverview(context, isDesktop),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildTitledContainer(
                      S.of(context).dashTotal,
                      child: Container(
                        height: 300,
                        child: TaskStatisticalChart(),
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
                            _getAList(context, todoList, flex: 3, title: S.of(context).dashToDoList),
                            SizedBox(width: 16),
                            _getAList(context, linkList, flex: 1, title: S.of(context).dashTopLinks),
                          ],
                        )
                      : Container(
                          width: double.infinity,
                          height: 850,
                          child: Column(
                            children: <Widget>[
                              _getAList(context, todoList, flex: 1, title: S.of(context).dashToDoList),
                              _getAList(context, linkList, flex: 1, title: S.of(context).dashTopLinks),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
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

  Container _buildTitledContainer(String title, {Widget? child, double? height}) {
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
          if (child != null) ...[const SizedBox(height: 10.0), child]
        ],
      ),
    );
  }

  _getAList(BuildContext context, List list, {required title, flex = 1}) {
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
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.blue,
          ),
        ),
        trailing: Icon(
          FontAwesomeIcons.alignRight,
        ),
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
          title: Text(
            Utils.isLocalEn(context) ? (v.titleEn ?? v.title) : v.title,
            style: TextStyle(color: Colors.black),
          ),
          trailing: v.trailing == null ? null : Text(v.trailing),
        ),
      );
    });
    var result = Expanded(
      flex: flex,
      child: Container(
        height: (list.length + 1) * 50.0,
        child: ListView(
          children: <Widget>[header, ...body],
        ),
      ),
    );
    return result;
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
