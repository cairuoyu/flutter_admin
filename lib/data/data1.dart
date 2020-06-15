import 'package:flutter/material.dart';
import 'package:flutter_admin/models/index.dart';
import 'package:flutter_admin/pages/dash/dashboard1.dart';
import 'package:flutter_admin/pages/image/imageUpload.dart';
import 'package:flutter_admin/pages/menu/menuList.dart';
import 'package:flutter_admin/pages/person/personList.dart';
import 'package:flutter_admin/pages/userInfo/userInfoEdit.dart';
import 'package:flutter_admin/pages/video/videoUpload.dart';
import 'package:flutter_admin/vo/listTileVO.dart';
import 'package:flutter_admin/vo/pageVO.dart';
import 'package:flutter_admin/vo/selectOptionVO.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<SelectOptionVO> deptIdList = [
  SelectOptionVO(value: '1', label: '技术部门'),
  SelectOptionVO(value: '2', label: '产品部'),
  SelectOptionVO(value: '3', label: '销售部'),
];
List<SelectOptionVO> genderList = [
  SelectOptionVO(value: '1', label: '男'),
  SelectOptionVO(value: '2', label: '女'),
];

List<SelectOptionVO> deptIdList_en = [
  SelectOptionVO(value: '1', label: 'Technical Department'),
  SelectOptionVO(value: '2', label: 'Product Department'),
  SelectOptionVO(value: '3', label: 'Sales'),
];
List<SelectOptionVO> genderList_en = [
  SelectOptionVO(value: '1', label: 'Male'),
  SelectOptionVO(value: '2', label: 'Female'),
];

List<PageVO> testPageVOAll_en = <PageVO>[
  PageVO(id: "1", icon: Icons.dashboard, title: 'Dashboard', widget: Dashboard1()),
  PageVO(id: "4", icon: Icons.people, title: 'Personnel List', widget: PersonList()),
  PageVO(id: "3", icon: Icons.menu, title: 'Menu List', widget: MenuList()),
  PageVO(id: "5", icon: Icons.grade, title: 'My Information', widget: UserInfoEdit()),
  PageVO(id: "6", icon: Icons.image, title: 'Image Upload', widget: ImageUpload()),
  PageVO(id: "7", icon: Icons.video_library, title: 'Video Upload', widget: VideoUpload()),
  PageVO(id: "2", icon: Icons.folder, title: 'Tree Structure - First level Menu', children: [
    PageVO(
      title: 'Secondary Menu',
      icon: FontAwesomeIcons.tree,
      children: [
        PageVO(title: 'Level Three Menu', icon: Icons.insert_drive_file),
      ],
    ),
    PageVO(
      title: 'Secondary menu',
      icon: Icons.insert_photo,
    )
  ]),
];

List<PageVO> testPageVOAll = <PageVO>[
  PageVO(id: "1", icon: Icons.dashboard, title: 'Dashboard', widget: Dashboard1()),
  PageVO(id: "4", icon: Icons.people, title: '人员管理', widget: PersonList()),
  PageVO(id: "3", icon: Icons.menu, title: '菜单管理', widget: MenuList()),
  PageVO(id: "5", icon: Icons.grade, title: '我的信息', widget: UserInfoEdit()),
  PageVO(id: "6", icon: Icons.image, title: '图片上传', widget: ImageUpload()),
  PageVO(id: "7", icon: Icons.video_library, title: '视频上传', widget: VideoUpload()),
  PageVO(id: "2", icon: Icons.folder, title: '树结构一级菜单', children: [
    PageVO(
      title: '二级菜单',
      icon: FontAwesomeIcons.tree,
      children: [
        PageVO(title: '三级菜单', icon: Icons.insert_drive_file),
      ],
    ),
    PageVO(
      title: '二级菜单',
      icon: Icons.insert_photo,
    )
  ]),
];

List<ListTileVO> todoList = [
  ListTileVO(title: '江西：清理“影子药师” 整治“挂证”乱象', trailing: '2020-01-11'),
  ListTileVO(title: '刘鹤会见国际科技合作奖获奖外国专家', trailing: '2020-01-11'),
  ListTileVO(title: '刘鹤在京检查2020年春运工作时强调：全面小康之年，让回家的路更温馨、更安全', trailing: '2020-01-11'),
  ListTileVO(title: '怀报国之志，勇攀创新高峰——国家科技奖励大会引发热烈反响', trailing: '2020-01-11'),
  ListTileVO(title: '宁夏回族自治区党委国家安全委员会办公室原副主任于霆被“双开”', trailing: '2020-01-11'),
  ListTileVO(title: '“冷板凳”拼出“热产业” 上海张江迈向科创策源高地', trailing: '2020-01-11'),
  ListTileVO(title: '北京已有8个区签约195名责任规划师', trailing: '2020-01-11'),
  // ListTileVO(title: '河北：生产安全事故起数和死亡人数实现“双下降”', trailing: '2020-01-11'),
  // ListTileVO(title: '我国增值肥料产量居全球之首', trailing: '2020-01-11'),
  // ListTileVO(title: '重庆工业经济逐步回暖', trailing: '2020-01-11'),
  // ListTileVO(title: '2019年闽台交流合作深化 入闽台胞逾387万', trailing: '2020-01-11'),
  // ListTileVO(title: '“中国天眼”通过国家验收 未来将加强国内外开放共享', trailing: '2020-01-11'),
];

List<ListTileVO> todoList_en = [
  ListTileVO(
      title: 'Jiangxi: clean up the "shadow pharmacist" and rectify the "hanging license" chaos',
      trailing: '2020-01-11'),
  ListTileVO(
      title: 'Liu He Meets with Foreign Experts Winning International Science and Technology Cooperation Award',
      trailing: '2020-01-11'),
  ListTileVO(
      title: 'Liu He Meets with Foreign Experts Winning International Science and Technology Cooperation Award',
      trailing: '2020-01-11'),
  ListTileVO(
      title:
          'Liu He emphasized when inspecting the work of the 2020 Spring Festival in Beijing: the year of comprehensive well-off, making the way home more warm and safer',
      trailing: '2020-01-11'),
  ListTileVO(
      title:
          'Huaibaozhizhizhi, Bravely Climb the Peak of Innovation——The National Science and Technology Awards Conference evokes enthusiastic response',
      trailing: '2020-01-11'),
  ListTileVO(
      title:
          'Ningxia Hui Autonomous Region Party Committee National Security Committee Office former Deputy Director Yu Ting was "double open"',
      trailing: '2020-01-11'),
  ListTileVO(
      title:
          '"Cold Bench" Spells Out "Hot Industry" Shanghai Zhangjiang Towards a Highland of Science and Technology and Innovation',
      trailing: '2020-01-11'),
  ListTileVO(title: 'Beijing has signed 195 responsible planners in 8 districts', trailing: '2020-01-11'),
];

List<ListTileVO> linkList = [
  ListTileVO(title: 'google'),
  ListTileVO(title: 'baidu'),
  ListTileVO(title: 'oracle'),
  ListTileVO(title: 'flutter'),
  ListTileVO(title: 'vue'),
  ListTileVO(title: 'javascript'),
  ListTileVO(title: 'java'),
];
