# FLUTTER_ADMIN
![GitHub](https://img.shields.io/github/license/cairuoyu/flutter_admin)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/cairuoyu/flutter_admin)
![GitHub repo size](https://img.shields.io/github/repo-size/cairuoyu/flutter_admin?color=yellow)
![Flutter version](https://img.shields.io/badge/flutter-2.2.0.pre.164-green)

>  简体中文 | [English](./README.en.md)

> 使用flutter实现的一个后台管理系统。本项目为前端，对应的后端为 https://github.com/cairuoyu/flutter_admin_backend

> 本项目作为一个基于Flutter开发Web、Android、iOS、Windows、macOS、Linux等多端应用程序的模板、例子、演示，在功能上提供多种实现方式，而且不断地在完善。通过这个项目，可以高效学习Flutter或快速地开发一个新的跨端应用。

---
## 功能
* 用户注册
* 登录登出
* 功能菜单
* Dashboard
* 角色管理
* 用户管理
* 部门管理
* 菜单管理
* 文章管理
* 图片上传
* 视频上传
* 人员管理
* 数据字典管理
* 留言
* 我的信息
* 图表
* 国际化
* 语言切换
* 主题切换
* 字体切换
* 独立配置文件
* 组件封装
* 导入导出Excel

## 技术
| 名称     | 技术                                                         |
| -------- | ------------------------------------------------------------ |
| 认证     | JWT                                                          |
| 路由管理 | Flutter Navigator 2                                          |
| 状态管理 | GetX                                                         |
| 缓存管理 | GetStorage                                                   |
| 网络请求 | Dio                                                          |
| 图表     | syncfusion_flutter_charts                                    |
| 富文本   | flutter_markdown                                             |
| 选择器   | image_picker、video_player、file_picker、flutter_colorpicker |

## 代码结构
```
├─config    配置文件
└─lib
    ├─api   服务接口
    ├─common    公共类
    ├─constants     常量类
    ├─data      数据类
    ├─enum      枚举类
    ├─generated     工具自动生成的国际化代码
    │  └─intl
    ├─l10n      国际化配置，修改后工具生成代码到generated文件夹下
    ├─models    模型类
    ├─pages     页面，各文件夹对应各功能
    │  ├─common
    │  ├─dash
    │  ├─dict
    │  ├─icon
    │  ├─image
    │  ├─layout
    │  ├─menu
    │  ├─message
    │  ├─person
    │  ├─role
    │  ├─subsystem
    │  ├─userInfo
    │  └─video
    └─utils     工具类

```

## 安装
```bash
flutter pub get
flutter create .
```

## 运行
```bash
# Web
flutter run -d chrome

# Windows
flutter run -d windows
```

## 打包
```bash
# Web
flutter build web

# Windows
flutter build windows

# Android
flutter build apk
```

## live demo
http://www.cairuoyu.com/flutter_admin

### web
![image](http://cairuoyu.com/screenshots/flutter_admin1.gif)
![image](http://cairuoyu.com/screenshots/flutter_admin2.gif)
![image](http://cairuoyu.com/screenshots/flutter_admin_login.png)
![image](http://cairuoyu.com/screenshots/flutter_admin_dashboard.png)
![image](http://cairuoyu.com/screenshots/flutter_admin_setting.png)
![image](http://cairuoyu.com/screenshots/flutter_admin_role_user.png)
![image](http://cairuoyu.com/screenshots/flutter_admin_personEdit.png)
![image](http://cairuoyu.com/screenshots/flutter_admin_menu.png)

### android
<img src="http://cairuoyu.com/screenshots/flutter_admin_dashboard_app.png" width="50%" alt="dashboard"/>
<img src="http://cairuoyu.com/screenshots/flutter_admin_setting_app.png" width="50%" alt="'setting"/>

### windows
![image](http://cairuoyu.com/screenshots/flutter_admin_windows.png)

## 加入讨论组
### 加我微信拉你入群
![image](http://cairuoyu.com/screenshots/qrcode_wechat_cry.png)

### QQ
851796663

