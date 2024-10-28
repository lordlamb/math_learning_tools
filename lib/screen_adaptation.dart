import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum Platform {
  mobile,
  desktop,
}

class ScreenAdaptation extends StatelessWidget {
  final Widget child;

  const ScreenAdaptation({super.key, required this.child});

  static Platform get platform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return Platform.mobile;
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.macOS:
        return Platform.desktop;
    }
  }

  static double getPx(num size) {
    var transformedSize = ScreenUtil().setWidth(size);
    return transformedSize;
  }

  static double getSp(num size) {
    return ScreenUtil().setSp(size);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: false,
      designSize: const Size(812, 375),
      minTextAdapt: true,
      builder: (context, child) => this.child,
    );
  }
}

extension ScreenAdaptationExtension on num {
  double get px => ScreenAdaptation.getPx(this);

  double get sp => ScreenAdaptation.getPx(this) * 0.8;
}
