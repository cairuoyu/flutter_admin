// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Confirm`
  String get pageConfirm {
    return Intl.message(
      'Confirm',
      name: 'pageConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Username is required`
  String get usernameRequired {
    return Intl.message(
      'Username is required',
      name: 'usernameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Register a new account`
  String get registerNewAccount {
    return Intl.message(
      'Register a new account',
      name: 'registerNewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Registration Successful`
  String get registerSuccess {
    return Intl.message(
      'Registration Successful',
      name: 'registerSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Clear Password`
  String get forgetPassword {
    return Intl.message(
      'Clear Password',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `login`
  String get login {
    return Intl.message(
      'login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords must be the same`
  String get passwordMismatch {
    return Intl.message(
      'Passwords must be the same',
      name: 'passwordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Login with existing account`
  String get haveAccountLogin {
    return Intl.message(
      'Login with existing account',
      name: 'haveAccountLogin',
      desc: '',
      args: [],
    );
  }

  /// `My Settings`
  String get mySettings {
    return Intl.message(
      'My Settings',
      name: 'mySettings',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get information {
    return Intl.message(
      'Information',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get dashUpcoming {
    return Intl.message(
      'Upcoming',
      name: 'dashUpcoming',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get dashInProgress {
    return Intl.message(
      'In Progress',
      name: 'dashInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get dashDone {
    return Intl.message(
      'Completed',
      name: 'dashDone',
      desc: '',
      args: [],
    );
  }

  /// `Finished`
  String get dashFinish {
    return Intl.message(
      'Finished',
      name: 'dashFinish',
      desc: '',
      args: [],
    );
  }

  /// `Total Sales`
  String get dashTotal {
    return Intl.message(
      'Total Sales',
      name: 'dashTotal',
      desc: '',
      args: [],
    );
  }

  /// `To Do's`
  String get dashToDoList {
    return Intl.message(
      'To Do\'s',
      name: 'dashToDoList',
      desc: '',
      args: [],
    );
  }

  /// `Popular Links`
  String get dashTopLinks {
    return Intl.message(
      'Popular Links',
      name: 'dashTopLinks',
      desc: '',
      args: [],
    );
  }

  /// `Request Error`
  String get requestError {
    return Intl.message(
      'Request Error',
      name: 'requestError',
      desc: '',
      args: [],
    );
  }

  /// `Personnel Name`
  String get personName {
    return Intl.message(
      'Personnel Name',
      name: 'personName',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get required {
    return Intl.message(
      'Required',
      name: 'required',
      desc: '',
      args: [],
    );
  }

  /// `Nickname`
  String get personNickname {
    return Intl.message(
      'Nickname',
      name: 'personNickname',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get personGender {
    return Intl.message(
      'Gender',
      name: 'personGender',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get personBirthday {
    return Intl.message(
      'Birthday',
      name: 'personBirthday',
      desc: '',
      args: [],
    );
  }

  /// `Department`
  String get personDepartment {
    return Intl.message(
      'Department',
      name: 'personDepartment',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Saved Successfully`
  String get saved {
    return Intl.message(
      'Saved Successfully',
      name: 'saved',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get query {
    return Intl.message(
      'Filter',
      name: 'query',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Modify`
  String get modify {
    return Intl.message(
      'Modify',
      name: 'modify',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get confirmDelete {
    return Intl.message(
      'Are you sure?',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// `Commit`
  String get commit {
    return Intl.message(
      'Commit',
      name: 'commit',
      desc: '',
      args: [],
    );
  }

  /// `User List`
  String get userList {
    return Intl.message(
      'User List',
      name: 'userList',
      desc: '',
      args: [],
    );
  }

  /// `Role List`
  String get roleList {
    return Intl.message(
      'Role List',
      name: 'roleList',
      desc: '',
      args: [],
    );
  }

  /// `Dict List`
  String get dictList {
    return Intl.message(
      'Dict List',
      name: 'dictList',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Operating`
  String get operating {
    return Intl.message(
      'Operating',
      name: 'operating',
      desc: '',
      args: [],
    );
  }

  /// `Creation Time`
  String get creationTime {
    return Intl.message(
      'Creation Time',
      name: 'creationTime',
      desc: '',
      args: [],
    );
  }

  /// `Update Time`
  String get updateTime {
    return Intl.message(
      'Update Time',
      name: 'updateTime',
      desc: '',
      args: [],
    );
  }

  /// `Drawer`
  String get drawer {
    return Intl.message(
      'Drawer',
      name: 'drawer',
      desc: '',
      args: [],
    );
  }

  /// `Side`
  String get side {
    return Intl.message(
      'Side',
      name: 'side',
      desc: '',
      args: [],
    );
  }

  /// `Menu Display`
  String get menuDisplay {
    return Intl.message(
      'Menu Display',
      name: 'menuDisplay',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `No Routing Mode`
  String get noRoutingMode {
    return Intl.message(
      'No Routing Mode',
      name: 'noRoutingMode',
      desc: '',
      args: [],
    );
  }

  /// `Routing Mode`
  String get routingMode {
    return Intl.message(
      'Routing Mode',
      name: 'routingMode',
      desc: '',
      args: [],
    );
  }

  /// `My Information`
  String get myInformation {
    return Intl.message(
      'My Information',
      name: 'myInformation',
      desc: '',
      args: [],
    );
  }

  /// `Select Menus`
  String get selectMenus {
    return Intl.message(
      'Select Menus',
      name: 'selectMenus',
      desc: '',
      args: [],
    );
  }

  /// `Select Users`
  String get selectUsers {
    return Intl.message(
      'Select Users',
      name: 'selectUsers',
      desc: '',
      args: [],
    );
  }

  /// `Unselected Users`
  String get unselectedUsers {
    return Intl.message(
      'Unselected Users',
      name: 'unselectedUsers',
      desc: '',
      args: [],
    );
  }

  /// `Selected Users`
  String get selectedUsers {
    return Intl.message(
      'Selected Users',
      name: 'selectedUsers',
      desc: '',
      args: [],
    );
  }

  /// `Please select [UnSelected Users]`
  String get selectUnselectedUsers {
    return Intl.message(
      'Please select [UnSelected Users]',
      name: 'selectUnselectedUsers',
      desc: '',
      args: [],
    );
  }

  /// `Please select [Selected Users]`
  String get selectSelectedUsers {
    return Intl.message(
      'Please select [Selected Users]',
      name: 'selectSelectedUsers',
      desc: '',
      args: [],
    );
  }

  /// `English Name`
  String get englishName {
    return Intl.message(
      'English Name',
      name: 'englishName',
      desc: '',
      args: [],
    );
  }

  /// `Sequence Number`
  String get sequenceNumber {
    return Intl.message(
      'Sequence Number',
      name: 'sequenceNumber',
      desc: '',
      args: [],
    );
  }

  /// `Remarks`
  String get remarks {
    return Intl.message(
      'Remarks',
      name: 'remarks',
      desc: '',
      args: [],
    );
  }

  /// `Parent Menu`
  String get parentMenu {
    return Intl.message(
      'Parent Menu',
      name: 'parentMenu',
      desc: '',
      args: [],
    );
  }

  /// `Root`
  String get root {
    return Intl.message(
      'Root',
      name: 'root',
      desc: '',
      args: [],
    );
  }

  /// `Image Title`
  String get imageTitle {
    return Intl.message(
      'Image Title',
      name: 'imageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Image Memo`
  String get imageMemo {
    return Intl.message(
      'Image Memo',
      name: 'imageMemo',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Video Title`
  String get videoTitle {
    return Intl.message(
      'Video Title',
      name: 'videoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Video Memo`
  String get videoMemo {
    return Intl.message(
      'Video Memo',
      name: 'videoMemo',
      desc: '',
      args: [],
    );
  }

  /// `Select Video`
  String get selectVideo {
    return Intl.message(
      'Select Video',
      name: 'selectVideo',
      desc: '',
      args: [],
    );
  }

  /// `The size cannot exceed 10M`
  String get sizeLimit {
    return Intl.message(
      'The size cannot exceed 10M',
      name: 'sizeLimit',
      desc: '',
      args: [],
    );
  }

  /// `Go to the Portal`
  String get goToThePortal {
    return Intl.message(
      'Go to the Portal',
      name: 'goToThePortal',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Enable`
  String get enable {
    return Intl.message(
      'Enable',
      name: 'enable',
      desc: '',
      args: [],
    );
  }

  /// `Disable`
  String get disable {
    return Intl.message(
      'Disable',
      name: 'disable',
      desc: '',
      args: [],
    );
  }

  /// `DictItem Code`
  String get dictItemCode {
    return Intl.message(
      'DictItem Code',
      name: 'dictItemCode',
      desc: '',
      args: [],
    );
  }

  /// `DictItem Name`
  String get dictItemName {
    return Intl.message(
      'DictItem Name',
      name: 'dictItemName',
      desc: '',
      args: [],
    );
  }

  /// `Please complete the table data`
  String get completeTheTableData {
    return Intl.message(
      'Please complete the table data',
      name: 'completeTheTableData',
      desc: '',
      args: [],
    );
  }

  /// `Leave me a message`
  String get leaveMessage {
    return Intl.message(
      'Leave me a message',
      name: 'leaveMessage',
      desc: '',
      args: [],
    );
  }

  /// `Leave me a message`
  String get allMessage {
    return Intl.message(
      'Leave me a message',
      name: 'allMessage',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Sub Title`
  String get subTitle {
    return Intl.message(
      'Sub Title',
      name: 'subTitle',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get content {
    return Intl.message(
      'Content',
      name: 'content',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `Download Template`
  String get downloadTemplate {
    return Intl.message(
      'Download Template',
      name: 'downloadTemplate',
      desc: '',
      args: [],
    );
  }

  /// `Import Excel`
  String get importExcel {
    return Intl.message(
      'Import Excel',
      name: 'importExcel',
      desc: '',
      args: [],
    );
  }

  /// `Export Excel`
  String get exportExcel {
    return Intl.message(
      'Export Excel',
      name: 'exportExcel',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Sub System List`
  String get subsystemList {
    return Intl.message(
      'Sub System List',
      name: 'subsystemList',
      desc: '',
      args: [],
    );
  }

  /// `Menu Management`
  String get menuManagement {
    return Intl.message(
      'Menu Management',
      name: 'menuManagement',
      desc: '',
      args: [],
    );
  }

  /// `Select the subsystem for menu management`
  String get menuTile {
    return Intl.message(
      'Select the subsystem for menu management',
      name: 'menuTile',
      desc: '',
      args: [],
    );
  }

  /// `Admin`
  String get admin {
    return Intl.message(
      'Admin',
      name: 'admin',
      desc: '',
      args: [],
    );
  }

  /// `Register other users to experience the menu permissions`
  String get loginTip {
    return Intl.message(
      'Register other users to experience the menu permissions',
      name: 'loginTip',
      desc: '',
      args: [],
    );
  }

  /// `Collapse`
  String get collapse {
    return Intl.message(
      'Collapse',
      name: 'collapse',
      desc: '',
      args: [],
    );
  }

  /// `Expand`
  String get expand {
    return Intl.message(
      'Expand',
      name: 'expand',
      desc: '',
      args: [],
    );
  }

  /// `Short Name`
  String get nameShort {
    return Intl.message(
      'Short Name',
      name: 'nameShort',
      desc: '',
      args: [],
    );
  }

  /// `Function`
  String get fun {
    return Intl.message(
      'Function',
      name: 'fun',
      desc: '',
      args: [],
    );
  }

  /// `Header`
  String get header {
    return Intl.message(
      'Header',
      name: 'header',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Hometown`
  String get hometown {
    return Intl.message(
      'Hometown',
      name: 'hometown',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Publish`
  String get publish {
    return Intl.message(
      'Publish',
      name: 'publish',
      desc: '',
      args: [],
    );
  }

  /// `Publish time`
  String get publishTime {
    return Intl.message(
      'Publish time',
      name: 'publishTime',
      desc: '',
      args: [],
    );
  }

  /// `Publish time start`
  String get publishTimeStart {
    return Intl.message(
      'Publish time start',
      name: 'publishTimeStart',
      desc: '',
      args: [],
    );
  }

  /// `Publish time end`
  String get publishTimeEnd {
    return Intl.message(
      'Publish time end',
      name: 'publishTimeEnd',
      desc: '',
      args: [],
    );
  }

  /// `Author`
  String get author {
    return Intl.message(
      'Author',
      name: 'author',
      desc: '',
      args: [],
    );
  }

  /// `Upload Article`
  String get uploadArticle {
    return Intl.message(
      'Upload Article',
      name: 'uploadArticle',
      desc: '',
      args: [],
    );
  }

  /// `Replay`
  String get replay {
    return Intl.message(
      'Replay',
      name: 'replay',
      desc: '',
      args: [],
    );
  }

  /// `Font`
  String get font {
    return Intl.message(
      'Font',
      name: 'font',
      desc: '',
      args: [],
    );
  }

  /// `Night mode`
  String get nightMode {
    return Intl.message(
      'Night mode',
      name: 'nightMode',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
