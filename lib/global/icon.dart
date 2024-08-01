import 'dart:ui';

import 'package:flutter_svg/svg.dart';

import 'color.dart';

enum AppIcons {
  home('home.svg'),
  profile('profile.svg'),
  checkboxChecked('checkbox_checked.svg'),
  checkboxUnchecked('checkbox_unchecked.svg');

  final String filename;

  const AppIcons(this.filename);

  String get path => 'asset/svg/icon/$filename';

  SvgPicture icon(double size, Color? color) {
    color ??= AppColors.grey_600;
    return SvgPicture.asset(
      path,
      height: size,
      width: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  SvgPicture preColoredIcon(double size) {
    return SvgPicture.asset(
      path,
      height: size,
      width: size,
    );
  }
}