import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/imageApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/generated/l10n.dart';
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
  List<int> imageBytes;

  @override
  void initState() {
    super.initState();
  }

  pickImage() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    String mimeType = mime(Path.basename(mediaData.fileName));
    imageBytes = mediaData.data;
    if (imageBytes != null) {
      setState(() {});
    }
  }

  save() async {
    var file = MultipartFile.fromBytes(imageBytes, contentType: MediaType("image", "png"), filename: "test");
    FormData formData = FormData.fromMap({"file": file});
    ResponeBodyApi responeBodyApi = await ImageApi.upload(formData);
    if (responeBodyApi.success) {
      BotToast.showText(text: S.of(context).saved);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          onPressed: () => save(),
          iconData: Icons.save,
        ),
      ],
    );
    var a = Column(
      children: <Widget>[
        bb,
        Row(
          children: <Widget>[
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              switchInCurve: Curves.easeIn,
              child: SizedBox(
                    width: 200,
                    child: imageBytes == null ? Container() : Image.memory(imageBytes),
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
