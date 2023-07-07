import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:im_animations/im_animations.dart';
import 'package:sizer/sizer.dart';
import '../constants.dart';

buildCircularIndicator() {
  return Center(
    child: HeartBeat(
        child: Image.asset(
          'assets/images/progress_logo.png',
          width: 75,
          height: 75,
        )),
  );
}

buildThreeBounceIndicator({Color? color}) {
  return Center(
    child: SpinKitThreeBounce(
      color: color ?? gMainColor,
      size: 15,
    ),
  );
}

buildAppBar(
    VoidCallback func, {
      bool isBackEnable = true,
      bool showNotificationIcon = false,
      VoidCallback? notificationOnTap,
      bool showHelpIcon = false,
      VoidCallback? helpOnTap,
      bool showSupportIcon = false,
      VoidCallback? supportOnTap,
      Color? helpIconColor,
      String? badgeNotification,
      bool showLogo = true,
      bool showChild = false,
      Widget? child,
    }) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Visibility(
            visible: isBackEnable,
            child: SizedBox(
              width: 2.h,
              child: IconButton(
                onPressed: func,
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: gMainColor,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Visibility(
            visible: showLogo,
            child: SizedBox(
              height: 6.h,
              child: const Image(
                image: AssetImage("assets/images/Gut welness logo.png"),
              ),
              //SvgPicture.asset("assets/images/splash_screen/Inside Logo.svg"),
            ),
          ),
          Visibility(
            visible: showChild,
            child: child ?? const SizedBox(),
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: showNotificationIcon,
            child: GestureDetector(
              child: badgeNotification == "1"
                  ? buildCustomBadge(
                child: Icon(
                  Icons.notifications,
                  color: gHintTextColor,
                ),
                // child: Icon(Icons.notifications,color: gHintTextColor,)
                // SvgPicture.asset(
                //   "assets/images/Notification.svg",
                //   height: 2.5.h,
                //   color: gHintTextColor,
                // ),
              )
                  : Icon(
                Icons.notifications,
                color: gHintTextColor,
              ),
              onTap: notificationOnTap,
            ),
          ),
          SizedBox(
            width: 3.25.w,
          ),
          Visibility(
            visible: showHelpIcon,
            child: GestureDetector(
              child: ImageIcon(
                AssetImage("assets/images/new_ds/help.png"),
                color: helpIconColor ?? gHintTextColor,
              ),
              onTap: helpOnTap,
            ),
          ),
          SizedBox(
            width: 3.25.w,
          ),
          Visibility(
            visible: showSupportIcon,
            child: GestureDetector(
              child: ImageIcon(
                AssetImage("assets/images/new_ds/support.png"),
                color: gHintTextColor,
              ),
              onTap: supportOnTap,
            ),
          ),
        ],
      )
    ],
  );
}

buildCustomBadge({required Widget child}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      child,
      const Positioned(
        top: 2,
        right: 2,
        child: CircleAvatar(
          radius: 4,
          backgroundColor: Colors.red,
        ),
      ),
    ],
  );
}
