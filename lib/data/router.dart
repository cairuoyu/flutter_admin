import 'package:flutter/material.dart';
import 'package:flutter_admin/pages/dash/dashboard1.dart';
import 'package:flutter_admin/pages/person/personList.dart';

import '../pages/image/imageUpload.dart';
import '../pages/menu/menuList.dart';
import '../pages/userInfo/userInfoEdit.dart';
import '../pages/video/videoUpload.dart';

Map<String, Widget> layoutBodys = {
  "/personList": PersonList(),
  "/dashboard1": Dashboard1(),
  "/menuList": MenuList(),
  "/userInfoEdit": UserInfoEdit(),
  "/imageUpload": ImageUpload(),
  "/videoUpload": VideoUpload(),
};
