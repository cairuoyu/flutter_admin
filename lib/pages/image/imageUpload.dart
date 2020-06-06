import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/imageApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/form2/cryInput.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/image.dart' as model;
import 'package:flutter_admin/models/responeBodyApi.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as Path;
import 'package:mime_type/mime_type.dart';

class ImageUpload extends StatefulWidget {
  @override
  ImageUploadState createState() => ImageUploadState();
}

class ImageUploadState extends State<ImageUpload> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  MediaInfo mediaInfo;
  model.Image image = model.Image();

  @override
  void initState() {
    super.initState();
  }

  pickImage() async {
    mediaInfo = await ImagePickerWeb.getImageInfo;
    if (mediaInfo.data != null) {
      if (image.title == null) {
        image.title = mediaInfo.fileName;
      }
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
    String mimeType = mime(Path.basename(mediaInfo.fileName));
    var mediaType = MediaType.parse(mimeType);
    var file = MultipartFile.fromBytes(mediaInfo.data, contentType: mediaType, filename: mediaInfo.fileName);
    Map map = image.toJson();
    map['file'] = file;
    FormData formData = FormData.fromMap(map);

    ResponeBodyApi responeBodyApi = await ImageApi.upload(formData);
    if (responeBodyApi.success) {
      BotToast.showText(text: S.of(context).saved);
      setState(() {
        this.mediaInfo = null;
      });
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
          onPressed: mediaInfo == null ? null : () => save(),
          iconData: Icons.save,
        ),
      ],
    );
    var a = Column(
      children: <Widget>[
        form,
        bb,
        Row(
          children: <Widget>[
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              switchInCurve: Curves.easeIn,
              child: SizedBox(
                    width: 200,
                    child: mediaInfo == null ? Container() : Image.memory(mediaInfo.data),
                  ) ??
                  Container(),
            ),
          ],
        ),
      ],
    );
    return a;
  }
}
