/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'dart:io';
import 'dart:typed_data';
import 'package:cry/cry_button_bar.dart';
import 'package:cry/cry_buttons.dart';
import 'package:cry/form/cry_input.dart';
import 'package:cry/model/image_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/image_api.dart';
import 'package:cry/cry_button.dart';
import 'package:cry/cry_dialog.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:cry/model/response_body_api.dart';
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
  PickedFile? pickedFile;
  final ImagePicker imagePicker = ImagePicker();
  ImageModel imageModel = ImageModel();
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Wrap(
        children: <Widget>[
          CryInput(
            label: S.of(context).imageTitle,
            value: imageModel.title,
            onSaved: (v) => {imageModel.title = v},
            validator: (v) {
              return v!.isEmpty ? S.of(context).required : null;
            },
          ),
          CryInput(
            label: S.of(context).imageMemo,
            value: imageModel.memo,
            onSaved: (v) => {imageModel.memo = v},
          ),
        ],
      ),
    );
    List<Widget> buttons = <Widget>[
      CryButton(
        label: S.of(context).gallery,
        iconData: Icons.photo,
        onPressed: () => pickImage(ImageSource.gallery),
      ),
      CryButtons.save(context, pickedFile == null ? null : () => save()),
      Text(
        S.of(context).sizeLimit,
        style: TextStyle(color: Colors.red),
      ),
    ];
    if (!kIsWeb) {
      buttons.insert(
        0,
        CryButton(
          label: S.of(context).camera,
          iconData: Icons.camera,
          onPressed: () => pickImage(ImageSource.camera),
        ),
      );
    }
    var bb = CryButtonBar(children: buttons);
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

  pickImage(ImageSource source) async {
    pickedFile = await imagePicker.getImage(source: source);
    if (pickedFile == null) {
      return;
    }
    imageBytes = await pickedFile!.readAsBytes();
    if (imageBytes!.length > 1000 * 1000 * 10) {
      cryAlert(context, S.of(context).sizeLimit);
      pickedFile = null;
      imageBytes = null;
      setState(() {});
      return;
    }

    setState(() {
      formKey.currentState!.save();
    });
  }

  save() async {
    FormState form = formKey.currentState!;
    if (!form.validate()) {
      return;
    }
    form.save();
    String filename = "test.png"; //todo
    String mimeType = mime(Path.basename(filename))!;
    var mediaType = MediaType.parse(mimeType);
    var file = MultipartFile.fromBytes(imageBytes!, contentType: mediaType, filename: filename);
    Map map = imageModel.toMap();
    map['file'] = file;
    FormData formData = FormData.fromMap(map as Map<String, dynamic>);

    ResponseBodyApi responseBodyApi = await ImageApi.upload(formData);
    if (responseBodyApi.success!) {
      Utils.toPortal(context, S.of(context).saved, S.of(context).goToThePortal);
      setState(() {
        this.pickedFile = null;
      });
    }
  }

  Widget previewImage() {
    if (pickedFile != null) {
      if (kIsWeb) {
        return Image.network(pickedFile!.path);
      } else {
        return Image.file(File(pickedFile!.path));
      }
    } else {
      return Container();
    }
  }
}
