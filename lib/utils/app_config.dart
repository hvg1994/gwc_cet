import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:sizer/sizer.dart';

import 'constants.dart';

class AppConfig{
  static AppConfig? instance;
  factory AppConfig() => instance ??= AppConfig._();
  AppConfig._();

  /// need to change this each time when we send the aab
  static const double androidVersion = 1.0;

  static const androidBundleId = "com.fembuddy.gwc_customer";

  static const String androidAppURL = "https://play.google.com/store/apps/details?id=com.fembuddy.gwc_customer";
  static const String iosAppURL = "https://play.google.com/store/apps/details?id=com.fembuddy.gwc_customer";


  SharedPreferences? preferences;

  Future<String?> getDeviceId() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    return deviceId;
  }

  // *** firebase ***
  static const String notification_channelId = 'high_importance_channel';
  static const String notification_channelName = 'pushnotificationappchannel';

  static const String deviceId = "device_id";

  static const String FCM_TOKEN = "fcm";

  static const String IS_LOGIN = "is_login";
  static const String last_login = "last_login";

  static const String User_Name = "userName";
  static const String User_Profile = "profile_pic";
  static const String User_Phone = "userPhone";




  static const String updateAppContent = "New Version Available Please Update";

  final String BEARER_TOKEN = "Bearer";

  static String slotErrorText = "Slots Not Available Please select different day";
  static String networkErrorText = "No Internet. Please Check Your Network Connection";
  static String oopsMessage = "OOps ! Something went wrong.";


  showSheet(BuildContext context, Widget viewWidget, {double? bottomSheetHeight, bool isDismissible = false}){
    return showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: isDismissible,
        enableDrag: false,
        context: context,
        backgroundColor: Colors.transparent,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     top: Radius.circular(30),
        //   ),
        // ),
        builder: (BuildContext context) {
          return AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            // EdgeInsets. only(bottom: MediaQuery.of(context).viewInsets),
            duration: const Duration(milliseconds: 100),
            child: Container(
              decoration: BoxDecoration(
                color: gWhiteColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              height: bottomSheetHeight ?? 40.h,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: kBottomSheetHeadYellow,
                        ),
                        child: Center(
                          child: Image.asset(bsHeadStarsIcon,
                            alignment: Alignment.topRight,
                            fit: BoxFit.scaleDown,
                            width: 30.w,
                            height: 10.h,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Flexible(
                          child: viewWidget
                      )
                    ],
                  ),
                  Positioned(
                      top: 8.h,
                      left: 5,
                      right: 5,
                      child: Container(
                          decoration: BoxDecoration(
                            // color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(blurRadius: 5, color: gHintTextColor.withOpacity(0.8))
                            ],
                          ),
                          child: CircleAvatar(
                            maxRadius: 40.sp,
                            backgroundColor: kBottomSheetHeadCircleColor,
                            child: Image.asset(bsHeadBellIcon,
                              fit: BoxFit.scaleDown,
                              width: 45,
                              height: 45,
                            ),
                          )
                      )
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  showSnackbar(BuildContext context, String message,{int? duration, bool? isError, SnackBarAction? action, double? bottomPadding}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor:(isError == null || isError == false) ? gPrimaryColor : gsecondaryColor.withOpacity(0.55),
        content: Text(message),
        margin: (bottomPadding != null) ? EdgeInsets.only(bottom: bottomPadding) : null,
        duration: Duration(seconds: duration ?? 3),
        action: action,
      ),
    );
  }



}