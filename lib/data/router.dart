import 'package:flutter/material.dart';
import 'package:flutter_admin/pages/dash/dashboard.dart';
import 'package:flutter_admin/pages/menu/menuDemoList.dart';
import 'package:flutter_admin/pages/person/personList.dart';

import '../pages/image/imageUpload.dart';
import '../pages/menu/menuDemoList.dart';
import '../pages/userInfo/userInfoEdit.dart';
import '../pages/video/videoUpload.dart';

Map<String, Widget> layoutBodys = {
  "/personList": PersonList(),
  "/dashboard": Dashboard(),
  "/menuDemoList": MenuDemoList(),
  "/userInfoEdit": UserInfoEdit(),
  "/imageUpload": ImageUpload(),
  "/videoUpload": VideoUpload(),
};
