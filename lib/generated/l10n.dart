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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
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

  /// `Name Required`
  String get personRequired {
    return Intl.message(
      'Name Required',
      name: 'personRequired',
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
  String get inquire {
    return Intl.message(
      'Filter',
      name: 'inquire',
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

  /// `Add User`
  String get increase {
    return Intl.message(
      'Add User',
      name: 'increase',
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

  /// `User List`
  String get userList {
    return Intl.message(
      'User List',
      name: 'userList',
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
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}