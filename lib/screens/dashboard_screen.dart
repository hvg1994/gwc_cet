import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:gwc_cet/screens/screen2/screen2.dart';
import 'package:gwc_cet/screens/screen3/screen3.dart';
import 'package:sizer/sizer.dart';
import '../utils/app_config.dart';
import '../utils/constants.dart';
import '../utils/widgets/exit_widget.dart';
import 'home/home_screen.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ConvexAppBarState> _appBarKey =
  GlobalKey<ConvexAppBarState>();

  int _bottomNavIndex = 0;

  final int save_prev_index = 0;

  bool showFab = true;


  pageCaller(int index) {
    switch (index) {
      case 0:
        {
          return HomeScreen();
        }
      case 1:
        {
          // return RadialSliderExample();
          return const Screen2();
        }
      case 2:
        {
          // this one
          return const SettingsScreen();
        }
    }
  }

  bool showProgress = false;
  final _pref = AppConfig().preferences!;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: pageCaller(_bottomNavIndex),
        bottomNavigationBar: ConvexAppBar(
          key: _appBarKey,
          style: TabStyle.react,
          backgroundColor: Colors.white,
          items: [
            TabItem(
              icon: _bottomNavIndex == 0
                  ? Image.asset(
                "assets/images/Group 3241.png",
                color: gsecondaryColor,
              )
                  : Image.asset(
                "assets/images/Group 3241.png",
              ),
            ),
            TabItem(
              icon: _bottomNavIndex == 1
                  ? Image.asset(
                "assets/images/Group 3331.png",
                color: gsecondaryColor,
              )
                  : Image.asset(
                "assets/images/Group 3331.png",
              ),
            ),
            TabItem(
              icon: _bottomNavIndex == 2
                  ? Image.asset(
                "assets/images/Group 3239.png",
                color: gsecondaryColor,
              )
                  : Image.asset(
                "assets/images/Group 3239.png",
              ),
            ),
          ],
          initialActiveIndex: _bottomNavIndex,
          onTap: onChangedTab,

        ),
      ),
    );
  }

  void onChangedTab(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }



  Future<bool> _onWillPop() {
    print('back pressed');
    print("_bottomNavIndex: $_bottomNavIndex");
    setState(() {
      if (_bottomNavIndex != 0) {
        if (_bottomNavIndex > save_prev_index ||
            _bottomNavIndex < save_prev_index) {
          _bottomNavIndex = save_prev_index;
          _appBarKey.currentState!.animateTo(_bottomNavIndex);
          setState(() {});
        } else {
          _bottomNavIndex = 0;
          _appBarKey.currentState!.animateTo(_bottomNavIndex);
          setState(() {});
        }
      } else {
        AppConfig().showSheet(context,
          const ExitWidget(),
          bottomSheetHeight: 45.h,
          // isDismissible: true,
        );
      }
    });
    return Future.value(false);
  }


}
