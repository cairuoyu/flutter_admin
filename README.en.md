# FLUTTER_ADMIN
![GitHub](https://img.shields.io/github/license/cairuoyu/flutter_admin)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/cairuoyu/flutter_admin)
![GitHub repo size](https://img.shields.io/github/repo-size/cairuoyu/flutter_admin?color=yellow)
![Flutter version](https://img.shields.io/badge/flutter-2.2.0.pre.164-green)

> [简体中文](./README.md) | English

> A Background Management System Implemented Using Flutter.This project for the front end, the corresponding back-end to https://github.com/cairuoyu/flutter_admin_backend

> As a template, example and demonstration for developing multi-terminal applications such as Web, Android, IOS, Windows, MacOS and Linux based on Flutter, this project provides a variety of implementation methods in terms of functions and is constantly being improved. With this project, you can learn Flutter efficiently or quickly develop a new cross-end application.

---
## Functional
* User Registration
* Login And Logout
* Function Menu
* Dashboard
* Role Management
* User Management
* Menu Management
* Article Management
* upload Picture
* Video Upload
* Personnel Management
* Data Dictionary Management
* Message
* My Information
* Chart
* Globalization
* Language Switch
* Theme Switch
* Font Switch
* Standalone configuration file
* Component packaging
* Import or Export Excle


## Technology
| Name               | Technology                                                   |
| ------------------ | ------------------------------------------------------------ |
| Authentication        | JWT                                                          |
| Routing management | Flutter Navigator 2                                          |
| State management   | GetX                                                         |
| Cache management   | GetStorage                                                   |
| Network request    | Dio                                                          |
| The chart          | syncfusion_flutter_charts                                    |
| The rich text      | flutter_markdown                                             |
| Picker             | image_picker、video_player、file_picker、flutter_colorpicker |


## The code structure
```
├─config    The configuration file
└─lib
    ├─api   The service interface
    ├─common    The public class
    ├─constants     Constant class
    ├─data      Data classes
    ├─enum      Enumeration class
    ├─generated     The tool automatically generates the internationalization code
    │  └─intl
    ├─l10n      Internationalize the configuration and modify the tool to generate code in the generated folder
    ├─models    Model class
    ├─pages     Page, each folder corresponds to each function
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
    └─utils     Utility class

```
## installation
```bash
flutter pub get
flutter create .
```

## run
```bash
# Web
flutter run -d chrome

# Windows
flutter run -d windows
```

## packaging
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

## Join Discussion Group
### Add me to WeChat to pull you into the group
![image](http://cairuoyu.com/screenshots/qrcode_wechat_cry.png)

### QQ
851796663