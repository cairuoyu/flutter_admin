/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description: 文章编辑

import 'package:cry/cry_button.dart';
import 'package:cry/cry_buttons.dart';
import 'package:cry/cry_file.dart';
import 'package:cry/form/cry_input.dart';
import 'package:cry/form/cry_select_date.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:cry/utils/cry_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/article_api.dart';
import 'package:flutter_admin/api/file_api.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/article.dart';
import 'package:dio/dio.dart';

class ArticleEdit extends StatefulWidget {
  final Article? article;

  const ArticleEdit({Key? key, this.article}) : super(key: key);

  @override
  _ArticleEditState createState() => _ArticleEditState();
}

class _ArticleEditState extends State<ArticleEdit> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Article article;

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
                label: S.of(context).title,
                value: article.title,
                required: true,
                onSaved: (v) => article.title = v,
              ),
              CryInput(
                label: S.of(context).subTitle,
                value: article.titleSub,
                onSaved: (v) => article.titleSub = v,
              ),
              CryInput(
                label: S.of(context).author,
                value: article.author,
                onSaved: (v) => article.author = v,
                width: 300,
              ),
              CrySelectDate(
                context,
                label: S.of(context).publishTime,
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
            buttonLabel: S.of(context).uploadArticle,
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
          CryButtons.commit(context, audit),
          CryButton(label: S.of(context).publish, onPressed: public, iconData: Icons.public),
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

  public() async {
    action((data) async => await ArticleApi.public(data));
  }

  action(action) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();

    ResponseBodyApi res = await action(article.toMap());
    if (res.success!) {
      CryUtils.message(S.of(context).success);
      Navigator.pop(context, true);
    }
  }
}
