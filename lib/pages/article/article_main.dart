import 'package:bot_toast/bot_toast.dart';
import 'package:cry/cry_dialog.dart';
import 'package:cry/form/cry_input.dart';
import 'package:cry/form/cry_select.dart';
import 'package:cry/form/cry_select_date.dart';
import 'package:flutter_admin/constants/constant_dict.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/utils/dict_util.dart';
import 'package:syncfusion_flutter_core/theme.dart';
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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Article article = Article();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var buttonBar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: [
        CryButtons.query(context, query),
        CryButtons.reset(context, reset),
        CryButtons.add(context, edit),
      ],
    );
    var form = Form(
      key: formKey,
      child: Wrap(
        alignment: WrapAlignment.start,
        children: [
          CryInput(
            label: 'title',
            value: article.title,
            width: 400,
            onSaved: (v) {
              article.title = v;
            },
          ),
          CryInput(
            label: 'titleSub',
            value: article.titleSub,
            width: 400,
            onSaved: (v) {
              article.titleSub = v;
            },
          ),
          CrySelect(
            label: 'Status',
            value: article.status,
            width: 200,
            dataList: DictUtil.getDictSelectOptionList(ConstantDict.CODE_ARTICLE_STATUS),
            onSaved: (v) {
              article.status = v;
            },
          ),
          CrySelectDate(
            context,
            label: '发布日期起',
            value: article.publishTimeStart,
            width: 200,
            onSaved: (v) {
              article.publishTimeStart = v;
            },
          ),
          CrySelectDate(
            context,
            label: '发布日期止',
            value: article.publishTimeEnd,
            width: 200,
            onSaved: (v) {
              article.publishTimeEnd = v;
            },
          ),
        ],
      ),
    );
    var dataGrid = SfDataGrid(
      source: ds,
      cellBuilder: getCellWidget,
      columns: <GridColumn>[
        GridWidgetColumn(
          mappingName: 'operation',
          headerText: 'Operation',
          // columnWidthMode: ColumnWidthMode.fill,
          width: 120,
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
          mappingName: 'titleSub',
          headerText: 'Sub Title',
          columnWidthMode: ColumnWidthMode.cells,
        ),
        GridTextColumn(
          mappingName: 'author',
          headerText: 'Author',
          width: 120,
        ),
        GridTextColumn(
          mappingName: 'publishTime',
          headerText: 'publishTime',
          width: 120,
        ),
        GridTextColumn(
          mappingName: 'status',
          headerText: 'Status',
          headerTextAlignment: Alignment.centerLeft,
        ),
      ],
    );
    var pager = SfDataPagerTheme(
      data: SfDataPagerThemeData(
        brightness: Brightness.light,
        selectedItemColor: Get.theme.primaryColor,
      ),
      child: SfDataPager(
        delegate: ds,
        rowsPerPage: 10,
        direction: Axis.horizontal,
      ),
    );
    var result = Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          form,
          buttonBar,
          Expanded(child: dataGrid),
          pager,
        ],
      ),
    );
    return result;
  }

  query() {
    formKey.currentState.save();
    ds.loadData(params: article.toMap());
  }

  reset() async {
    article = Article();
    formKey.currentState.reset();
    await ds.loadData(params: {});
  }

  delete(ids) async {
    cryConfirm(context, S.of(context).confirmDelete, (context) async {
      await ArticleApi.removeByIds(ids);
      Navigator.of(context).pop();
      ds.loadData();
    });
  }

  edit({Article article}) async {
    var result = await Get.to(ArticleEdit(article: article));
    if (result ?? false) {
      ds.loadData();
    }
  }

  Widget getCellWidget(BuildContext context, GridColumn column, int rowIndex) {
    if (column.mappingName == 'operation') {
      var result = ButtonBar(
        alignment: MainAxisAlignment.start,
        children: [
          CryButtons.edit(context, () => edit(article: ds.dataSource[rowIndex]), showLabel: false),
          CryButtons.delete(context, () => delete([ds.dataSource[rowIndex].id]), showLabel: false),
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

  PageModel pageModel = PageModel();
  Map params = {};

  loadData({Map params}) async {
    if (params != null) {
      this.params = params;
    }
    BotToast.showLoading();
    var responseBodyApi = await ArticleApi.page(RequestBodyApi(page: pageModel, params: this.params).toMap());
    BotToast.closeAllLoading();
    pageModel = responseBodyApi.data != null ? PageModel.fromMap(responseBodyApi.data) : PageModel();
    _articleList = pageModel.records.map((element) => Article.fromMap(element)).toList();
    notifyDataSourceListeners();
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
      case 'titleSub':
        return article.titleSub;
        break;
      case 'author':
        return article.author;
        break;
      case 'publishTime':
        return article.publishTime;
        break;
      case 'status':
        return DictUtil.getDictItemName(article.status, ConstantDict.CODE_ARTICLE_STATUS);
        break;
      default:
        return '--';
        break;
    }
  }

  @override
  int get rowCount => pageModel.total;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex, int startRowIndex, int rowsPerPage) async {
    pageModel.current = startRowIndex / pageModel.size + 1;
    await loadData();
    return true;
  }
}
