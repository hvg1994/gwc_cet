import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:gwc_cet/controller/cet_team_data/cet_team_controller.dart';
import 'package:gwc_cet/utils/constants.dart';
import 'package:gwc_cet/utils/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../api/api_response.dart';
import '../../model/cet_data_model/get_cet_data_model.dart';
import '../../utils/app_config.dart';
import '../../utils/widgets/base_class.dart';
import '../../utils/widgets/no_data_found.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  late CetTeamDataController _cetController;

  @override
  Widget build(BuildContext context) {
    _cetController = Provider.of<CetTeamDataController>(context, listen: false);
    _cetController.getCetTeamListData();
    return DefaultTabController(
      length: 2,
      child: BaseClass(
        isBackEnable: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userViewCard(),
            TabBar(
                labelColor: gTextColor,
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                unselectedLabelColor: gHintTextColor,
                labelStyle: fieldTextStyle(
                    color: gTextColor,
                    fontFamily: kFontBold
                ),
                unselectedLabelStyle: fieldTextStyle(
                    color: gHintTextColor,
                    fontFamily: kFontBook
                ),
                isScrollable: false,
                indicatorColor: gsecondaryColor,
                labelPadding: EdgeInsets.only(
                    right: 7.w, left: 2.w, top: 1.h, bottom: 1.h),
                indicatorPadding: EdgeInsets.only(right: 5.w),
                tabs: const [
                  Text('Registered'),
                  Text('Transfered'),
                ]),
            Expanded(
              child: TabBarView(children: [
                buildPendingCustomer(context),
                buildCompletedCustomer(context),
                // buildBridged(),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  final _pref = AppConfig().preferences;
  late String userName = _pref?.getString(AppConfig.User_Name) ?? '';

  userViewCard(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      child: RichText(
        text: TextSpan(
          text: "Hi, ",
            style: fieldTextStyle(
                fontSize: midSubHeadingFontSize
            ),
          children:[
            TextSpan(
              text: userName,
              style: fieldTextStyle(
                fontFamily: kFontBold,
                color: gHintTextColor,
                fontSize: midSubHeadingFontSize
              )
            )
          ]
        ),
      ),
    );
  }

  buildPendingCustomer(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
          SizedBox(height: 2.h),
          Consumer<CetTeamDataController>(
            builder: (_, viewModel, __){
              switch (viewModel.cetTeamDataResponse.status) {
                case Status.LOADING:
                  print("MARAJ :: LOADING");
                  return LoadingWidget();
                case Status.ERROR:
                  print("MARAJ :: ERROR");
                  return ErrorWidget(viewModel.cetTeamDataResponse.message ?? "NA");
                case Status.COMPLETED:
                  print("MARAJ :: COMPLETED");
                  List<PendingDetails> _pendingList = (viewModel.cetTeamDataResponse.data as GetCetDataModel).pendingDetails ?? [];

                  if(_pendingList.isEmpty){
                    return NoDataFound();
                  }
                  else{
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _pendingList.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _pendingList[index].name ?? '',
                                        style: fieldTextStyle(),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Text(
                                        "${_pendingList[index].age ?? ''} ${_pendingList[index].gender ?? ''}",
                                        style: fieldTextStyle(),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Text(
                                        _pendingList[index].email ?? '',
                                        style: fieldTextStyle(),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Text(
                                        _pendingList[index].phone ?? '',
                                        style: fieldTextStyle(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showTranferSheet(context, _pendingList[index].userId.toString());
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.h, horizontal: 2.w),
                                          decoration: BoxDecoration(
                                            // color: gsecondaryColor,

                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: gsecondaryColor
                                              )
                                          ),
                                          child: Center(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(Icons.check, color: gsecondaryColor, size: 12.sp,),
                                                Text(
                                                  'Transfer To Success Team',
                                                  textAlign: TextAlign.center,
                                                  style: btnTextStyle(color: gsecondaryColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          sendOnWhatsApp(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.h, horizontal: 2.w),
                                          decoration: BoxDecoration(
                                            // color: gsecondaryColor,
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: gPrimaryColor
                                              )
                                          ),
                                          child: Center(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(Icons.share, color: gPrimaryColor, size: 12.sp,),
                                                Text(
                                                  'Send Link',
                                                  textAlign: TextAlign.center,
                                                  style: btnTextStyle(color: gPrimaryColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                height: 1,
                                margin: EdgeInsets.symmetric(vertical: 1.5.h),
                                color: Colors.grey.withOpacity(0.3),
                              ),
                            ],
                          ),
                        );
                      }),
                    );
                  }
                default:
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }

  buildCompletedCustomer(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
          SizedBox(height: 2.h),
          Consumer<CetTeamDataController>(
            builder: (_, viewModel, __){
              switch (viewModel.cetTeamDataResponse.status) {
                case Status.LOADING:
                  print("MARAJ :: LOADING");
                  return LoadingWidget();
                case Status.ERROR:
                  print("MARAJ :: ERROR");
                  return ErrorWidget(viewModel.cetTeamDataResponse.message ?? "NA");
                case Status.COMPLETED:
                  print("MARAJ :: COMPLETED");
                  List<CompletedDetails> _completedList = (viewModel.cetTeamDataResponse.data as GetCetDataModel).completedDetails ?? [];

                  if(_completedList.isEmpty){
                    return NoDataFound();
                  }
                  else{
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _completedList.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _completedList[index].name ?? '',
                                            style: fieldTextStyle(),
                                          ),
                                          SizedBox(height: 0.5.h),
                                          Text(
                                            "${_completedList[index].age ?? ''} ${_completedList[index].gender ?? ''}",
                                            style: fieldTextStyle(),
                                          ),
                                          SizedBox(height: 0.5.h),
                                          Text(
                                            _completedList[index].email ?? '',
                                            style: fieldTextStyle(),
                                          ),
                                          SizedBox(height: 0.5.h),
                                          Text(
                                            _completedList[index].phone ?? '',
                                            style: fieldTextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            copyToClipboard(context);
                                          },
                                          child: IntrinsicHeight(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 0.8.h, horizontal: 2.w),
                                              decoration: BoxDecoration(
                                                // color: gsecondaryColor,
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: gPrimaryColor
                                                  )
                                              ),
                                              child: Center(
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(Icons.copy_outlined, color: gPrimaryColor, size: 12.sp,),
                                                    Text(
                                                      'Copy',
                                                      textAlign: TextAlign.center,
                                                      style: btnTextStyle(color: gPrimaryColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: 5,
                                        // ),
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     sendOnWhatsApp(context);
                                        //   },
                                        //   child: IntrinsicHeight(
                                        //     child: Container(
                                        //       padding: EdgeInsets.symmetric(
                                        //           vertical: 1.h, horizontal: 2.w),
                                        //       decoration: BoxDecoration(
                                        //         // color: gsecondaryColor,
                                        //           borderRadius: BorderRadius.circular(5),
                                        //           border: Border.all(
                                        //               color: gPrimaryColor
                                        //           )
                                        //       ),
                                        //       child: Center(
                                        //         child: Row(
                                        //           crossAxisAlignment: CrossAxisAlignment.end,
                                        //           mainAxisSize: MainAxisSize.min,
                                        //           mainAxisAlignment: MainAxisAlignment.center,
                                        //           children: <Widget>[
                                        //             Icon(Icons.share, color: gPrimaryColor, size: 12.sp,),
                                        //             Text(
                                        //               'Send Link',
                                        //               textAlign: TextAlign.center,
                                        //               style: btnTextStyle(color: gPrimaryColor),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 1,
                                margin: EdgeInsets.symmetric(vertical: 1.5.h),
                                color: Colors.grey.withOpacity(0.3),
                              ),
                            ],
                          ),
                        );
                      }),
                    );
                  }

                default:
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }

  markAsCompleted(BuildContext context, String userId) async{
    await _cetController.sendMarkAsCompleted(userId);
    Navigator.pop(context);
  }

  showTranferSheet(BuildContext context, String userId){
    return AppConfig().showSheet(
        context,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Are you sure",
                style: TextStyle(
                    fontSize: bottomSheetHeadingFontSize,
                    fontFamily: bottomSheetHeadingFontFamily,
                    height: 1.4
                ),
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
                'Do you want to Transfer To Success Team?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: gTextColor,
                  fontSize: bottomSheetSubHeadingXFontSize,
                  fontFamily: bottomSheetSubHeadingMediumFont,
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Consumer<CetTeamDataController>(
                builder: (_, data, __){
                  if(data.cetTeamDataResponse.status == Status.LOADING){
                    return Center(child: buildCircularIndicator());
                  }
                  else{
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            markAsCompleted(context, userId);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 12.w),
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
                          onTap: () => Navigator.of(context).pop(false),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 12.w),
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
                    );
                  }
                }
            ),
            SizedBox(height: 1.h)
          ],
        ),
      bottomSheetHeight: 50.h
    );
  }

  static const String message = "Congrats on starting your Gut Healing Journey! To get started please download the Gut Wellness Club App from the links below.\n\n"
      "Android: [Link] \n"
      "IOS: [Link] \n"
      "Waiting for you in the app!";

  // claimDialog(BuildContext context) {
  sendOnWhatsApp(BuildContext context) async{
    String msg = message;
    // String url = "https://wa.me/?text=$msg";
    // var encoded = Uri.encodeFull(url);
    // try{
    //   if(Platform.isIOS){
    //     await launchUrl(Uri.parse(url));
    //   }
    //   else{
    //     await launchUrl(Uri.parse(url));
    //   }
    // } on Exception{
    //   print("error");
    // }
    var res = await FlutterShareMe().shareToWhatsApp(
        msg: msg);

    print("res: $res");
    if(res == "false"){
      AppConfig().showSnackbar(context, "WhatsApp Not Available", isError: true);
    }
  }

  LoadingWidget() {
    return Center(
      child: buildCircularIndicator(),
    );
  }

  ErrorWidget(String error){
    return Flexible(child: Center(
        child: Text(error)
    ));
  }

  copyToClipboard(BuildContext context) async{
    Clipboard.setData(ClipboardData(text: message)).then((_){
      AppConfig().showSnackbar(context, "Copied to clipboard");
    });
  }
}
