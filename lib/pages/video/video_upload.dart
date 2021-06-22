/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description: 视频上传

import 'dart:typed_data';

import 'package:cry/cry_button_bar.dart';
import 'package:cry/cry_buttons.dart';
import 'package:cry/form/cry_input.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/video_api.dart';
import 'package:cry/cry_button.dart';
import 'package:cry/cry_dialog.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/video.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:mime_type/mime_type.dart';
import 'package:video_player/video_player.dart';

import 'aspect_ratio_video.dart';

class VideoUpload extends StatefulWidget {
  @override
  VideoUploadState createState() => VideoUploadState();
}

class VideoUploadState extends State<VideoUpload> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PickedFile? pickedFile;
  final ImagePicker videoPicker = ImagePicker();
  VideoPlayerController? controller;
  Video video = Video();
  Uint8List? videoBytes;

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
            label: S.of(context).videoTitle,
            value: video.title,
            onSaved: (v) => {video.title = v},
            validator: (v) {
              return v!.isEmpty ? S.of(context).required : null;
            },
          ),
          CryInput(
            label: S.of(context).videoMemo,
            value: video.memo,
            onSaved: (v) => {video.memo = v},
          ),
        ],
      ),
    );
    var bb = CryButtonBar(
      children: <Widget>[
        CryButton(
          label: S.of(context).selectVideo,
          onPressed: () => pickVideo(),
          iconData: Icons.video_library,
        ),
        CryButtons.save(context, pickedFile == null ? null : () => save()),
        Text(
          S.of(context).sizeLimit,
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
            previewVideo(),
          ],
        ),
      ),
    );

    return result;
  }

  pickVideo() async {
    pickedFile = await videoPicker.getVideo(source: ImageSource.gallery);
    if (pickedFile == null || !mounted) {
      return;
    }
    videoBytes = await pickedFile!.readAsBytes();
    if (videoBytes!.length > 1000 * 1000 * 10) {
      cryAlert(context, S.of(context).sizeLimit);
      pickedFile = null;
      videoBytes = null;
      controller = null;
      setState(() {});
      return;
    }
//    await this.disposeController();
    controller = VideoPlayerController.network(pickedFile!.path);
    await controller!.initialize();
    await controller!.setLooping(true);
    await controller!.play();
    formKey.currentState!.save();
    setState(() {});
  }

  Widget previewVideo() {
    return controller == null
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: AspectRatioVideo(controller),
          );
  }

  save() async {
    FormState form = formKey.currentState!;
    if (!form.validate()) {
      return;
    }
    form.save();
    String filename = "test.avi"; //todo
    String mimeType = mime(Path.basename(filename))!;
    var mediaType = MediaType.parse(mimeType);
    // Uint8List uint8list = await pickedFile.readAsBytes();
    var file = MultipartFile.fromBytes(videoBytes!, contentType: mediaType, filename: filename);
    Map map = video.toMap();
    map['file'] = file;
    FormData formData = FormData.fromMap(map as Map<String, dynamic>);

    ResponseBodyApi responseBodyApi = await VideoApi.upload(formData);
    if (responseBodyApi.success!) {
      Utils.toPortal(context, S.of(context).saved, S.of(context).goToThePortal);
      setState(() {
//        this.disposeController();
      });
    }
  }

  @override
  void deactivate() {
    if (controller != null) {
      controller!.setVolume(0.0);
      controller!.pause();
    }
    super.deactivate();
  }

  void disposeController() async {
    if (controller != null) {
      await controller!.setVolume(0.0);
      await controller!.dispose();
      controller = null;
    }
  }

  @override
  void dispose() async {
    disposeController();
    super.dispose();
  }
}
