import 'package:flutter/material.dart';
import 'package:gwc_cet/utils/constants.dart';
import 'package:gwc_cet/utils/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

class BaseClass extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool isBackEnable;
  const BaseClass({Key? key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.isBackEnable = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: gBgColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 1.h),
                child: buildAppBar(() { },
                    isBackEnable: isBackEnable
                ),
              ),
              Expanded(
                child: Padding(
                  padding: padding,
                  child: child,
                ),
              )
            ],
          ),
        )
    );
  }
}
