import 'package:cry/cry_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/file_api.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:dio/dio.dart';

class CryFile extends StatefulWidget {
  final Function onSaved;
  final String initFileUrl;

  const CryFile({Key key, this.onSaved, this.initFileUrl}) : super(key: key);

  @override
  _CryFileState createState() => _CryFileState();
}

class _CryFileState extends State<CryFile> {
  String content = '';

  @override
  void initState() {
    initContent();

    super.initState();
  }

  initContent() async {
    if (widget.initFileUrl?.isEmpty ?? true) {
      return;
    }
    var res;
    try {
      res = await Dio().get(widget.initFileUrl);
    } catch (e) {
      print('请求文件出错：[' + widget.initFileUrl + ']' + e.toString());
      return;
    }
    content = res.data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var result = Expanded(
      child: Column(
        children: [
          CryButton(
              iconData: Icons.file_download,
              label: '上传文章',
              onPressed: pickFile),
          Expanded(
            child: Card(
              child: Markdown(data: content),
            ),
          ),
        ],
      ),
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
    var file = MultipartFile.fromBytes(bytes, filename: filename);
    FormData formData = FormData.fromMap({"file": file});
    var res = await FileApi.upload(formData);
    widget.onSaved(res.data);
    setState(() {
      content = String.fromCharCodes(bytes);
    });
  }
}
