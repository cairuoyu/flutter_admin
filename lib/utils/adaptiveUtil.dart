import 'dart:ui';

import 'package:flutter/material.dart';

//enum DisplayType {
//  desktop,
//  mobile,
//}
//
//const _desktopPortraitBreakpoint = 700.0;
//const _desktopLandscapeBreakpoint = 1000.0;
//
//DisplayType displayTypeOf(BuildContext context) {
//  final orientation = MediaQuery.of(context).orientation;
//  final width = MediaQuery.of(context).size.width;
//
//  if ((orientation == Orientation.landscape && width > _desktopLandscapeBreakpoint) ||
//      (orientation == Orientation.portrait && width > _desktopPortraitBreakpoint)) {
//    return DisplayType.desktop;
//  } else {
//    return DisplayType.mobile;
//  }
//}
//
//bool isDisplayDesktop(BuildContext context) {
//  return displayTypeOf(context) == DisplayType.desktop;
//}
//
//bool isDisplaySmallDesktop(BuildContext context) {
//  return isDisplayDesktop(context) && MediaQuery.of(context).size.width < _desktopLandscapeBreakpoint;
//}

const desktopBreakpoint = 1000.0;

bool isDisplayDesktop(BuildContext context) {
  return MediaQuery.of(context).size.width > desktopBreakpoint;
}

bool isDisplayDesktopInit() {
  return window.physicalSize.width > desktopBreakpoint;
}
