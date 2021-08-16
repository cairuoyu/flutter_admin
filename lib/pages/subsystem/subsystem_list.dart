/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_all.dart';
import 'package:cry/cry_list_view.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/subsystem_api.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/subsystem.dart';
import 'package:flutter_admin/utils/utils.dart';

typedef OpenSubsystemBuilder<S> = Widget Function(Subsystem subsystem);

class SubsystemList extends StatefulWidget {
  final OpenSubsystemBuilder? openSubsystemBuilder;

  SubsystemList({Key? key, this.openSubsystemBuilder}) : super(key: key);

  @override
  _SubsystemListState createState() => _SubsystemListState();
}

class _SubsystemListState extends State<SubsystemList> {
  List<Subsystem> subsystemList = [];

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (subsystemList.isEmpty) {
      return Container();
    }
    var listView = CryListView(
      appBar: AppBar(
        title: Text(S.of(context).menuTile),
        actions: [CryButtons.reset(context, () async => _loadData())],
      ),
      count: subsystemList.length,
      getCell: (index) {
        Subsystem subsystem = subsystemList[index];
        return ListTile(
          onTap: () => Utils.fullscreenDialog(widget.openSubsystemBuilder!(subsystem)),
          leading: Text((index + 1).toString()),
          title: Text(subsystem.name!),
          subtitle: Text(subsystem.code!),
        );
      },
    );
    return listView;
  }

  _loadData() async {
    ResponseBodyApi responseBodyApi = await SubsystemApi.listEnable();
    subsystemList = List.from(responseBodyApi.data).map((e) => Subsystem.fromMap(e)).toList();
    if (mounted) this.setState(() {});
  }
}
