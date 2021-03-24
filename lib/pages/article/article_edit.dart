import 'package:cry/cry_button.dart';
import 'package:cry/cry_buttons.dart';
import 'package:cry/cry_file.dart';
import 'package:cry/form/cry_input.dart';
import 'package:cry/form/cry_select_date.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/article_api.dart';
import 'package:flutter_admin/api/file_api.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/article.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:dio/dio.dart';

class ArticleEdit extends StatefulWidget {
  final Article article;

  const ArticleEdit({Key key, this.article}) : super(key: key);

  @override
  _ArticleEditState createState() => _ArticleEditState();
}

class _ArticleEditState extends State<ArticleEdit> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Article article;

  @override
  void initState() {
    article = widget.article ?? Article();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Column(
        children: [
          Wrap(
            children: [
              CryInput(
                label: 'title',
                value: article.title,
                required: true,
                onSaved: (v) => article.title = v,
              ),
              CryInput(
                label: 'titleSub',
                value: article.titleSub,
                onSaved: (v) => article.titleSub = v,
              ),
              CryInput(
                label: 'author',
                value: article.author,
                onSaved: (v) => article.author = v,
                width: 300,
              ),
              CrySelectDate(
                context,
                label: 'publishTime',
                value: article.publishTime,
                onSaved: (v) => article.publishTime = v,
                width: 200,
              ),
            ],
          ),
          CryFile(
            initFileUrl: widget.article?.fileUrl,
            onSaved: (MultipartFile file) async {
              FormData formData = FormData.fromMap({"file": file});
              var res = await FileApi.upload(formData);
              article.fileUrl = res.data;
            },
            buttonLabel: '上传文章',
            allowedExtensions: ['md', 'txt'],
          ),
        ],
      ),
    );
    var result = Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).add),
        actions: [
          CryButtons.save(context, save),
          CryButton(label: '提交审核', onPressed: audit, iconData: Icons.done),
          CryButton(label: '发布', onPressed: public, iconData: Icons.public),
        ],
      ),
      body: form,
    );
    return result;
  }

  save() {
    action((data) async => await ArticleApi.save(data));
  }

  audit() {
    action((data) async => await ArticleApi.audit(data));
  }

  public() {
    action((data) async => await ArticleApi.public(data));
  }

  action(action) async {
    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();

    ResponseBodyApi res = await action(article.toMap());
    if (res.success) {
      Utils.message(S.of(context).success);
      Get.back(result: true);
    }
  }
}
