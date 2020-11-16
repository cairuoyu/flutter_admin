import 'dart:io';
import 'dart:typed_data';
import 'package:cry/form/cry_input.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/image_api.dart';
import 'package:cry/cry_button.dart';
import 'package:cry/cry_dialog.dart';
import 'package:flutter_admin/models/image.dart' as model;
import 'package:flutter_admin/models/response_body_api.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as Path;
import 'package:mime_type/mime_type.dart';

class ImageUpload extends StatefulWidget {
  @override
  ImageUploadState createState() => ImageUploadState();
}

class ImageUploadState extends State<ImageUpload> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PickedFile pickedFile;
  final ImagePicker imagePicker = ImagePicker();
  model.Image image = model.Image();
  Uint8List imageBytes;
  final limitMessage = '图片大小不能超过10M';

  @override
  void initState() {
    super.initState();
  }

  pickImage() async {
    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    imageBytes = await pickedFile.readAsBytes();
    if (imageBytes.length > 1000 * 1000 * 10) {
      cryAlert(context, limitMessage);
      pickedFile = null;
      imageBytes = null;
      setState(() {});
      return;
    }

    if (pickedFile != null) {
      setState(() {
        formKey.currentState.save();
      });
    }
  }

  save() async {
    FormState form = formKey.currentState;
    if (!form.validate()) {
      return;
    }
    form.save();
    String filename = "test.png"; //todo
    String mimeType = mime(Path.basename(filename));
    var mediaType = MediaType.parse(mimeType);
    var file = MultipartFile.fromBytes(imageBytes, contentType: mediaType, filename: filename);
    Map map = image.toJson();
    map['file'] = file;
    FormData formData = FormData.fromMap(map);

    ResponseBodyApi responseBodyApi = await ImageApi.upload(formData);
    if (responseBodyApi.success) {
      Utils.toPortal(context, '保存成功！', '前往门户查看图片', "http://www.cairuoyu.com/flutter_portal");
      setState(() {
        this.pickedFile = null;
      });
    }
  }

  Widget previewImage() {
    if (pickedFile != null) {
      if (kIsWeb) {
        return Image.network(pickedFile.path);
      } else {
        return Image.file(File(pickedFile.path));
      }
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Wrap(
        children: <Widget>[
          CryInput(
            label: '图片标题',
            value: image.title,
            onSaved: (v) => {image.title = v},
            validator: (v) {
              return v.isEmpty ? '必填' : null;
            },
          ),
          CryInput(
            label: '图片描述',
            value: image.memo,
            onSaved: (v) => {image.memo = v},
          ),
        ],
      ),
    );
    var bb = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        CryButton(
          label: '选择图片',
          onPressed: () => pickImage(),
          iconData: Icons.photo_size_select_actual,
        ),
        CryButton(
          label: '保存',
          onPressed: pickedFile == null ? null : () => save(),
          iconData: Icons.save,
        ),
        Text(
          limitMessage,
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
    var result = Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            form,
            bb,
            previewImage(),
          ],
        ),
      ),
    );

    return result;
  }
}
