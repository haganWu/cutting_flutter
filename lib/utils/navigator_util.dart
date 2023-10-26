import 'package:flutter/material.dart';

class NavigatorUtil {
  // static BuildContext? _context;
  //
  // static updateContext(BuildContext context) {
  //   NavigatorUtil._context = context;
  // }

  /// 跳转到指定页面
  static Future<T?> push<T extends Object?>(BuildContext context, Widget page) {
    return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

}
