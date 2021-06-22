/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:flutter_admin/models/link_model.dart';
import 'package:flutter_admin/models/task_statistical_model.dart';
import 'package:flutter_admin/models/todo_model.dart';

final List<TodoModel> todoList = [
  TodoModel(
    title: '江西：清理“影子药师” 整治“挂证”乱象',
    titleEn: 'Jiangxi: clean up the "shadow pharmacist" and rectify the "hanging license" chaos',
    trailing: '2020-01-11',
  ),
  TodoModel(
    title: '刘鹤会见国际科技合作奖获奖外国专家',
    titleEn: 'Liu He Meets with Foreign Experts Winning International Science and Technology Cooperation Award',
    trailing: '2020-01-11',
  ),
  TodoModel(
    title: '刘鹤在京检查2020年春运工作时强调：全面小康之年，让回家的路更温馨、更安全',
    titleEn: 'Liu He Meets with Foreign Experts Winning International Science and Technology Cooperation Award',
    trailing: '2020-01-11',
  ),
  TodoModel(
    title: '怀报国之志，勇攀创新高峰——国家科技奖励大会引发热烈反响',
    titleEn: 'Huaibaozhizhizhi, Bravely Climb the Peak of Innovation——The National Science and Technology Awards Conference evokes enthusiastic response',
    trailing: '2020-01-11',
  ),
  TodoModel(
    title: '宁夏回族自治区党委国家安全委员会办公室原副主任于霆被“双开”',
    titleEn: 'Ningxia Hui Autonomous Region Party Committee National Security Committee Office former Deputy Director Yu Ting was "double open"',
    trailing: '2020-01-11',
  ),
  TodoModel(
    title: '“冷板凳”拼出“热产业” 上海张江迈向科创策源高地',
    titleEn: '"Cold Bench" Spells Out "Hot Industry" Shanghai Zhangjiang Towards a Highland of Science and Technology and Innovation',
    trailing: '2020-01-11',
  ),
  TodoModel(
    title: '北京已有8个区签约195名责任规划师',
    titleEn: 'Beijing has signed 195 responsible planners in 8 districts',
    trailing: '2020-01-11',
  ),
  // TodoModel(title: '河北：生产安全事故起数和死亡人数实现“双下降”', trailing: '2020-01-11'),
  // TodoModel(title: '我国增值肥料产量居全球之首', trailing: '2020-01-11'),
  // TodoModel(title: '重庆工业经济逐步回暖', trailing: '2020-01-11'),
  // TodoModel(title: '2019年闽台交流合作深化 入闽台胞逾387万', trailing: '2020-01-11'),
  // TodoModel(title: '“中国天眼”通过国家验收 未来将加强国内外开放共享', trailing: '2020-01-11'),
];

final List<LinkModel> linkList = [
  LinkModel(title: 'google'),
  LinkModel(title: 'baidu'),
  LinkModel(title: 'oracle'),
  LinkModel(title: 'flutter'),
  LinkModel(title: 'vue'),
  LinkModel(title: 'javascript'),
  LinkModel(title: 'java'),
];

final List<TaskStatisticalModel> taskStatisticalList = <TaskStatisticalModel>[
  TaskStatisticalModel(timeName: '1月', upcomingCount: 43, inProgressCount: 37, doneCount: 41, finishCount: 20),
  TaskStatisticalModel(timeName: '2月', upcomingCount: 3, inProgressCount: 20, doneCount: 11, finishCount: 40),
  TaskStatisticalModel(timeName: '3月', upcomingCount: 23, inProgressCount: 10, doneCount: 21, finishCount: 23),
  TaskStatisticalModel(timeName: '4月', upcomingCount: 13, inProgressCount: 23, doneCount: 41, finishCount: 0),
  TaskStatisticalModel(timeName: '5月', upcomingCount: 23, inProgressCount: 47, doneCount: 31, finishCount: 40),
  TaskStatisticalModel(timeName: '6月', upcomingCount: 28, inProgressCount: 9, doneCount: 21, finishCount: 22),
  TaskStatisticalModel(timeName: '7月', upcomingCount: 12, inProgressCount: 12, doneCount: 11, finishCount: 40),
  TaskStatisticalModel(timeName: '8月', upcomingCount: 9, inProgressCount: 3, doneCount: 1, finishCount: 4),
  TaskStatisticalModel(timeName: '9月', upcomingCount: 8, inProgressCount: 10, doneCount: 23, finishCount: 4),
  TaskStatisticalModel(timeName: '10月', upcomingCount: 18, inProgressCount: 44, doneCount: 6, finishCount: 30),
  TaskStatisticalModel(timeName: '11月', upcomingCount: 23, inProgressCount: 33, doneCount: 21, finishCount: 20),
  TaskStatisticalModel(timeName: '12月', upcomingCount: 34, inProgressCount: 10, doneCount: 34, finishCount: 10),
];
