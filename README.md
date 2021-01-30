# FLUTTER_ADMIN
![GitHub](https://img.shields.io/github/license/cairuoyu/flutter_admin)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/cairuoyu/flutter_admin)
![GitHub repo size](https://img.shields.io/github/repo-size/cairuoyu/flutter_admin?color=yellow)
![Flutter version](https://img.shields.io/badge/flutter-1.25.0--8.3.pre-green)

>  简体中文 | [English](./README.en.md)

> 使用flutter实现的一个后台管理系统

> 本项目作为一个基于Flutter开发Web、App的模板，在功能上提供多种实现方式，包括弹窗、表单风格、表格等，而且不断地在完善。通过这个项目，可以高效学习Flutter或快速地开发一个新的应用。

---
## 功能技术
* 用户注册
* 登录登出
* 功能菜单
* Dashboard
* 角色管理
* 用户管理
* 部门管理
* 菜单管理
* 图片上传
* 视频上传
* 人员管理
* 数据字典管理
* 留言
* 我的信息
* 国际化
* 语言切换
* 主题切换
* 组件封装
* 独立配置文件
* JWT
* 导入导出Excel

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
flutter packages get
flutter create .
```

## 运行
```bash
flutter run -d chrome
```

## live demo
http://www.cairuoyu.com/flutter_admin

![image](http://cairuoyu.com/screenshots/flutter_admin_login.png)
![image](http://cairuoyu.com/screenshots/flutter_admin_dashboard.png)
![image](http://cairuoyu.com/screenshots/flutter_admin_setting.png)
![image](http://cairuoyu.com/screenshots/flutter_admin_role_user.png)
![image](http://cairuoyu.com/screenshots/flutter_admin_personEdit.png)
![image](http://cairuoyu.com/screenshots/flutter_admin_menu.png)

<img src="http://cairuoyu.com/screenshots/flutter_admin_dashboard_app.png" width="50%"/>
<img src="http://cairuoyu.com/screenshots/flutter_admin_setting_app.png" width="50%"/>

## 加入讨论组
### 微信群
![image](http://cairuoyu.com/screenshots/qrcode_wechat_flutter.png)

### QQ
851796663


