import 'package:bot_toast/bot_toast.dart';
import 'package:cry/cry_buttons.dart';
import 'package:cry/model/page_model.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/article_api.dart';
import 'package:flutter_admin/models/article.dart';
import 'package:flutter_admin/pages/article/article_edit.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ArticleMain extends StatefulWidget {
  @override
  _ArticleMainState createState() => _ArticleMainState();
}

class _ArticleMainState extends State<ArticleMain> {
  ArticleDataSource ds = ArticleDataSource();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dataGrid = SfDataGrid(
      source: ds,
      cellBuilder: getCellWidget,
      columns: <GridColumn>[
        GridWidgetColumn(
          mappingName: 'operation',
          headerText: 'Operation',
          columnWidthMode: ColumnWidthMode.header,
          // width: 50,
          textAlignment: Alignment.center,
        ),
        GridTextColumn(
          mappingName: 'id',
          headerText: 'ID',
          columnWidthMode: ColumnWidthMode.cells,
        ),
        GridTextColumn(
          mappingName: 'title',
          headerText: 'Title',
          columnWidthMode: ColumnWidthMode.fill,
          // textAlignment: Alignment.center,
        ),
        GridTextColumn(
          mappingName: 'status',
          headerText: 'Status',
          headerTextAlignment: Alignment.centerLeft,
        ),
      ],
    );
    var buttonBar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: [
        CryButtons.query(context, loadData),
        CryButtons.add(context, edit),
      ],
    );
    var result = Scaffold(
      body: Column(
        children: [
          buttonBar,
          Expanded(child: dataGrid),
        ],
      ),
    );
    return result;
  }

  edit({Article article}) async {
    var result = await Get.to(ArticleEdit(article: article));
    if (result ?? false) {
      loadData();
    }
  }

  loadData() async {
    BotToast.showLoading();
    var responseBodyApi = await ArticleApi.page(RequestBodyApi(page: PageModel(), params: {}).toMap());
    BotToast.closeAllLoading();
    var page = responseBodyApi.data != null ? PageModel.fromMap(responseBodyApi.data) : PageModel();
    var articleList = page.records.map((element) => Article.fromMap(element)).toList();
    ds.setData(articleList);
    ds.sort();
  }

  Widget getCellWidget(BuildContext context, GridColumn column, int rowIndex) {
    if (column.mappingName == 'operation') {
      var result = ButtonBar(
        children: [
          CryButtons.edit(context, () => edit(article: ds.dataSource[rowIndex]), showLabel: false),
        ],
      );
      return result;
    }
    return Text('--');
  }
}

class ArticleDataSource extends DataGridSource<Article> {
  ArticleDataSource({List<Article> articleList}) {
    _articleList = articleList ?? [];
  }

  setData(List<Article> articleList) {
    _articleList = articleList;
    notifyListeners();
  }

  List<Article> _articleList;

  @override
  List<Article> get dataSource => _articleList;

  @override
  getValue(Article article, String columnName) {
    switch (columnName) {
      case 'id':
        return article.id;
        break;
      case 'title':
        return article.title;
        break;
      case 'status':
        return article.status;
        break;
      default:
        return '--';
        break;
    }
  }
}
