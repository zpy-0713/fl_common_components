import 'package:flutter/material.dart';

/// 屏幕类型枚举
enum ScreenType {
  /// 手机尺寸
  mobile,

  /// 平板尺寸
  tablet,

  /// 桌面尺寸
  desktop,
}

/// 响应式工具类
class ResponsiveUtils {
  /// 默认手机断点
  static const double defaultPhoneBreakpoint = 450.0;

  /// 默认平板断点
  static const double defaultTabletBreakpoint = 900.0;

  /// 检查当前是否为手机尺寸
  static bool isMobile(
    BuildContext context, {
    double phoneBreakpoint = defaultPhoneBreakpoint,
  }) {
    return MediaQuery.of(context).size.width < phoneBreakpoint;
  }

  /// 检查当前是否为平板尺寸
  static bool isTablet(
    BuildContext context, {
    double phoneBreakpoint = defaultPhoneBreakpoint,
    double tabletBreakpoint = defaultTabletBreakpoint,
  }) {
    final double width = MediaQuery.of(context).size.width;
    return width >= phoneBreakpoint && width < tabletBreakpoint;
  }

  /// 检查当前是否为桌面尺寸
  static bool isDesktop(
    BuildContext context, {
    double tabletBreakpoint = defaultTabletBreakpoint,
  }) {
    return MediaQuery.of(context).size.width >= tabletBreakpoint;
  }

  /// 获取当前屏幕类型
  static ScreenType getScreenType(
    BuildContext context, {
    double phoneBreakpoint = defaultPhoneBreakpoint,
    double tabletBreakpoint = defaultTabletBreakpoint,
  }) {
    if (isMobile(context, phoneBreakpoint: phoneBreakpoint)) {
      return ScreenType.mobile;
    } else if (isTablet(
      context,
      phoneBreakpoint: phoneBreakpoint,
      tabletBreakpoint: tabletBreakpoint,
    )) {
      return ScreenType.tablet;
    } else {
      return ScreenType.desktop;
    }
  }

  /// 根据屏幕类型返回不同的值
  static T responsive<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
    double phoneBreakpoint = defaultPhoneBreakpoint,
    double tabletBreakpoint = defaultTabletBreakpoint,
  }) {
    final ScreenType screenType = getScreenType(
      context,
      phoneBreakpoint: phoneBreakpoint,
      tabletBreakpoint: tabletBreakpoint,
    );

    switch (screenType) {
      case ScreenType.mobile:
        return mobile;
      case ScreenType.tablet:
        return tablet ?? mobile;
      case ScreenType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }
}
