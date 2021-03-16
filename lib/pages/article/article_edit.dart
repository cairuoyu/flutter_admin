import 'package:cry/cry_buttons.dart';
import 'package:cry/form/cry_input.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/article_api.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/article.dart';
import 'package:flutter_admin/pages/article/cry_file.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CryInput(
            label: 'title',
            value: article.title,
            required: true,
            onSaved: (v) => article.title = v,
          ),
          CryFile(
            initFileUrl: widget.article?.fileUrl,
            onSaved: (v) => article.fileUrl = v,
          ),
        ],
      ),
    );
    var result = Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).add),
        actions: [CryButtons.save(context, save)],
      ),
      body: form,
    );
    return result;
  }

  save() async {
    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();

    ResponseBodyApi res = await ArticleApi.save(article.toMap());
    if (res.success) {
      Utils.message(S.of(context).success);
      Get.back(result: true);
    }
  }
}
