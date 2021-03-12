import 'package:cry/cry_button.dart';
import 'package:cry/cry_buttons.dart';
import 'package:cry/form/cry_input.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_admin/api/article_api.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/article.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ArticleEdit extends StatefulWidget {
  @override
  _ArticleEditState createState() => _ArticleEditState();
}

class _ArticleEditState extends State<ArticleEdit> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Article article;
  MultipartFile file;
  String content = '';

  @override
  void initState() {
    article = Article();
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
            onSaved: (v) {
              article.title = v;
            },
          ),
          CryButton(iconData: Icons.file_download, label: '上传文章', onPressed: pickFile),
          Expanded(
            child: Card(
              child: Markdown(data: content),
            ),
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

  pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['md', 'txt'],
    );

    if (result == null) {
      return;
    }
    var bytes = result.files.first.bytes;
    String filename = result.files.first.name;
    file = MultipartFile.fromBytes(bytes, filename: filename);
    formKey.currentState.save(); //todo
    setState(() {
      content = String.fromCharCodes(bytes);
    });
  }

  save() async {
    if (file == null) {
      Utils.snackbar('请上传文章');
      return;
    }
    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();

    var map = article.toMap();
    map['file'] = file;
    var data = FormData.fromMap(map);
    ResponseBodyApi res = await ArticleApi.save(data);
    if (res.success) {
      Utils.message(S.of(context).success);
      Get.back(result: true);
    }
  }
}
