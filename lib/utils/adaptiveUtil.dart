import 'dart:ui';

import 'package:flutter/material.dart';

const desktopBreakpoint = 1000.0;

bool isDisplayDesktop(BuildContext context) {
  return MediaQuery.of(context).size.width > desktopBreakpoint;
}

bool isDisplayDesktopInit() {
  return window.physicalSize.width > desktopBreakpoint;
}
