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
      columns: <GridColumn>[
        GridTextColumn(
          mappingName: 'id',
          headerText: 'ID',
          columnWidthMode: ColumnWidthMode.cells,
          headerTextAlignment: Alignment.centerLeft,
        ),
        GridTextColumn(
          mappingName: 'title',
          headerText: 'Title',
          columnWidthMode: ColumnWidthMode.fill,
          // headerTextAlignment: Alignment.centerLeft,
        ),
        GridTextColumn(
          mappingName: 'status',
          headerText: 'Status',
          headerTextAlignment: Alignment.center,
        ),
      ],
    );
    var buttonBar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: [
        CryButtons.query(context, loadData),
        CryButtons.add(context, add),
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

  add() async {
    var result = await Get.to(ArticleEdit());

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
