/*
Api's used:

var logoutUrl = "api/logout";

 */

import 'package:flutter/material.dart';
import 'package:gwc_cet/controller/auth_controller/auth_controller.dart';
import 'package:gwc_cet/screens/auth/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../api/api_response.dart';
import '../../utils/app_config.dart';
import '../../utils/constants.dart';
import '../../utils/widgets/base_class.dart';
import '../../utils/widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SharedPreferences _pref = AppConfig().preferences!;

  @override
  Widget build(BuildContext context) {
    return BaseClass(
      child: Padding(
        padding: EdgeInsets.only(top: 1.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 4.h,
            ),
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: gWhiteColor,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2.5,
                  color: gsecondaryColor,
                ),
              ),
              child: CircleAvatar(
                radius: 7.h,
                backgroundImage: NetworkImage(
                    "${_pref.getString(AppConfig.User_Profile)}"),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              "${_pref.getString(AppConfig.User_Name)}",
              textAlign: TextAlign.center,
              style: fieldTextStyle(
                fontFamily: kFontBold,
                fontSize: headingFontSize
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              "${_pref.getString(AppConfig.User_Phone)}",
              textAlign: TextAlign.center,
              style: fieldTextStyle(
                  fontFamily: kFontMedium,
                  fontSize: subHeadingFontSize
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 5.h),
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                decoration: const BoxDecoration(
                  color: gWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: kLineColor,
                      offset: Offset(2, 3),
                      blurRadius: 5,
                    )
                  ],
                  // border: Border.all(
                  //   width: 1,
                  //   color: kLineColor,
                  // ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            profileTile(
                                "assets/images/Group 2753.png", "My Profile",
                                    () {
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //     const MyProfileDetails(),
                                  //   ),
                                  // );
                                }),
                            //
                            // profileTile("assets/images/Group 2747.png", "FAQ",
                            //         () {
                            //       Navigator.of(context).push(
                            //         MaterialPageRoute(
                            //           builder: (context) => const FaqScreen(),
                            //         ),
                            //       );
                            //     }),

                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => AppConfig().showSheet(
                        context, logoutWidget(),
                        bottomSheetHeight: 45.h,
                        isDismissible: true,
                      ),
                      child: Container(
                        margin:  EdgeInsets.symmetric(horizontal: 30.w),
                        padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 3.w),
                        decoration: BoxDecoration(
                          color: gWhiteColor,
                          borderRadius:  BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: kLineColor,
                              offset: Offset(2, 3),
                              blurRadius: 5,
                            )
                          ],
                          // border: Border.all(
                          //   width: 1,
                          //   color: kLineColor,
                          // ),
                        ),
                        child: Row(
                          children: [
                            Image(
                              image: const AssetImage(
                                "assets/images/Group 2744.png",
                              ),
                              height: 4.h,
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              "Logout",
                              style: TextStyle(
                                color: gTextColor,
                                fontFamily: kFontBook,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  profileTile(String image, String title, func) {
    return InkWell(
      onTap: func,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 1.h),
            padding: const EdgeInsets.all(5),
            // decoration: BoxDecoration(
            //   // color: gBlackColor.withOpacity(0.05),
            //   borderRadius: BorderRadius.circular(5),
            // ),
            child: Image(
              image: AssetImage(image),
              height: 4.h,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: gTextColor,
                fontFamily: kFontBook,
                fontSize: 11.sp,
              ),
            ),
          ),
          GestureDetector(
            onTap: func,
            child: Icon(
              Icons.arrow_forward_ios,
              color: gTextColor,
              size: 1.8.h,
            ),
          ),
        ],
      ),
    );
  }

  void logOut() async {
    final model = Provider.of<AuthController>(context,listen: false);
    await model.logout();

    if(model.authResponse.status == Status.COMPLETED)
      {
        clearAllUserDetails();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_)=> LoginScreen()),
                (route) => route.isFirst);
      }
  }

  clearAllUserDetails(){
    _pref.setBool(AppConfig.IS_LOGIN, false);
    _pref.remove(AppConfig().BEARER_TOKEN);

    _pref.remove(AppConfig.User_Name);
    _pref.remove(AppConfig.User_Name);
    _pref.remove(AppConfig.User_Profile);
    _pref.remove(AppConfig.User_Phone);
  }


  bool showLogoutProgress = false;

  var logoutProgressState;

  logoutWidget() {
    return StatefulBuilder(
        builder: (_, setstate){
          logoutProgressState = setstate;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "We will miss you.",
                  style: TextStyle(
                      fontSize: bottomSheetHeadingFontSize,
                      fontFamily: bottomSheetHeadingFontFamily,
                      height: 1.4),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  color: kLineColor,
                  thickness: 1.2,
                ),
              ),
              Center(
                child: Text(
                  'Do you really want to logout?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: gTextColor,
                    fontSize: bottomSheetSubHeadingXFontSize,
                    fontFamily: bottomSheetSubHeadingMediumFont,
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              (showLogoutProgress)
                  ? Center(child: buildCircularIndicator())
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => logOut(),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 12.w),
                      decoration: BoxDecoration(
                          color: gsecondaryColor,
                          border: Border.all(color: kLineColor, width: 0.5),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "YES",
                        style: TextStyle(
                          fontFamily: kFontMedium,
                          color: gWhiteColor,
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 12.w),
                      decoration: BoxDecoration(
                          color: gWhiteColor,
                          border: Border.all(color: kLineColor, width: 0.5),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "NO",
                        style: TextStyle(
                          fontFamily: kFontMedium,
                          color: gsecondaryColor,
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h)
            ],
          );
        }
    );
  }
}
