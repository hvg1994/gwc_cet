import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gwc_cet/model/auth_model/auth_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../../api/api_response.dart';
import '../../controller/auth_controller/auth_controller.dart';
import '../../utils/app_config.dart';
import '../../utils/constants.dart';
import '../../utils/widgets/unfocus_widget.dart';
import '../../utils/widgets/widgets.dart';
import '../../utils/widgets/will_pop_widget.dart';
import '../dashboard_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late final AuthController viewModel;


  final formKey = GlobalKey<FormState>();
  final SharedPreferences _pref = AppConfig().preferences!;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late bool passwordVisibility;
  String deviceToken = "";

  @override
  void initState() {
    super.initState();
    getFcm();
    passwordVisibility = false;
    emailController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    viewModel = Provider.of<AuthController>(context,listen: false);
  }

  void getFcm() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    deviceToken = preferences.getString(AppConfig.FCM_TOKEN) ?? '';
    setState(() {});
    print("deviceToken111: $deviceToken");
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      child: UnfocusWidget(
        child: Scaffold(
          body: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  children: [
                    SizedBox(height: 12.h),
                    Center(
                      child: Image(
                        image: const AssetImage(
                            "assets/images/Gut welness logo.png"),
                        height: 12.h,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "WELCOME TO",
                          style: TextStyle(
                            fontFamily: kFontBold,
                            fontSize: headingFontSize
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "CET",
                          style: TextStyle(
                              fontFamily: kFontMedium,
                              fontSize: headingFontSize
                          ),
                        ),
                      ),
                    ),
                    buildForm(),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  buildForm() {
    return Form(
      key: formKey,
      child: Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              children: [
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 10.w),
                //   child: Text(
                //     "Lorem ipsum is simply dummy text of the printing and typesetting industry",
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //         height: 1.5,
                //         fontFamily: "GothamBold",
                //         color: gSecondaryColor,
                //         fontSize: 10.sp),
                //   ),
                // ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  cursorColor: gTextColor,
                  textAlignVertical: TextAlignVertical.center,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Email ID';
                    } else if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Please enter your valid Email ID';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.mail_outline_sharp,
                      color: gTextColor,
                      size: 15.sp,
                    ),
                    hintText: "Email",
                    hintStyle: hintStyle,
                    suffixIcon: (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(emailController.value.text))
                        ? emailController.text.isEmpty
                        ? Container(
                      width: 0,
                    )
                        : InkWell(
                      onTap: () {
                        emailController.clear();
                      },
                      child: const Icon(
                        Icons.close,
                        color: gTextColor,
                        size: 15,
                      ),
                    )
                        : Icon(
                      Icons.check_circle,
                      color: gPrimaryColor,
                      size: 15.sp,
                    ),
                  ),
                  style: fieldTextStyle(),
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 5.h),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: gTextColor,
                  controller: passwordController,
                  obscureText: !passwordVisibility,
                  textAlignVertical: TextAlignVertical.center,
                  style: fieldTextStyle(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the Password';
                    }
                    if (!RegExp('[a-zA-Z]')
                    // RegExp(
                    //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,20}$')
                        .hasMatch(value)) {
                      return 'Password may contains alpha numeric';
                    }
                    if (value.length < 6 || value.length > 20) {
                      return 'Password must me 6 to 20 characters';
                    }
                    if (!RegExp('[a-zA-Z]')
                    // RegExp(
                    //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,20}$')
                        .hasMatch(value)) {
                      return 'Password must contains \n '
                          '1-symbol 1-alphabet 1-number';
                    }
                    return null;
                  },
                  onFieldSubmitted: (val) {
                    formKey.currentState!.validate();
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline_sharp,
                      color: gTextColor,
                      size: 15.sp,
                    ),
                    hintText: "Password",
                    hintStyle: hintStyle,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          passwordVisibility = !passwordVisibility;
                        });
                      },
                      child: Icon(
                        passwordVisibility
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: passwordVisibility
                            ? gTextColor
                            : gHintTextColor,
                        size: 15.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                SizedBox(height: 10.h),
                Consumer<AuthController>(
                    builder: (_, data, __)
                    {
                      print(data);
                      print("data.authResponse.status: ${data.authResponse.status == Status.LOADING}");
                      return GestureDetector(
                  onTap: (data.authResponse.status == Status.LOADING)
                      ? null
                      : () {
                    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => DashboardScreen()), (_)=> true);

                    buildLogin();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    decoration: BoxDecoration(
                      color: gsecondaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: (data.authResponse.status == Status.LOADING)
                        ? buildThreeBounceIndicator(color: gWhiteColor)
                        : Center(
                      child: Text(
                        'LOGIN',
                        style: btnTextStyle(color: gWhiteColor),
                      ),
                    ),
                  ),
                );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void buildLogin() async {
    if (formKey.currentState!.validate()) {
      // if(deviceToken.isEmpty){
      //   await FirebaseMessaging.instance.getToken().then((value) {
      //     setState(() {
      //       deviceToken = value!;
      //       print("Device Token is Login: $deviceToken");
      //     });
      //   });
      // }

      viewModel.sendLoginDetailsVm(
          emailController.text.toString(),
          passwordController.text.toString(),
          deviceToken
      ).then((value) {
        if(viewModel.authResponse.status == Status.COMPLETED){
          print(viewModel.authResponse.data);

          AuthModel model = viewModel.authResponse.data;

          _pref.setBool(AppConfig.IS_LOGIN, true);
          _pref.setString(AppConfig().BEARER_TOKEN, model.accessToken ?? '');

          _pref.setString(AppConfig.User_Name, model.user?.name ?? '');
          _pref.setString(AppConfig.User_Profile, model.user?.profile ?? '');
          _pref.setString(AppConfig.User_Phone, model.user?.phone ?? '');


          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => DashboardScreen()), (_)=> true);
        }
        else if(viewModel.authResponse.status == Status.ERROR){
          print(viewModel.authResponse.message);
          AppConfig().showSnackbar(context, viewModel.authResponse.message ?? '', isError: true);
        }
        print("after");
      });
    }
    else {
      AppConfig().showSnackbar(context, "Please complete the form Properly", isError: true);
    }
  }

  // void storeUserProfile(String accessToken) async {
  //   final profile =
  //   await SuccessMemberProfileService(repository: userRepository)
  //       .getSuccessMemberProfileService(accessToken);
  //   if (profile.runtimeType == GetUserModel) {
  //     GetUserModel model1 = profile as GetUserModel;
  //     print("model1.datqbUserIda!.: ${model1.data!.address}");
  //
  //     _pref.setString(GwcApi.successMemberName, model1.data?.name ?? "");
  //     _pref.setString(GwcApi.successMemberProfile, model1.data?.profile ?? "");
  //     _pref.setString(GwcApi.successMemberAddress, model1.data?.phone ?? "");
  //
  //     print("Success Name : ${_pref.getString(GwcApi.successMemberName)}");
  //     print(
  //         "Success Profile : ${_pref.getString(GwcApi.successMemberProfile)}");
  //     print(
  //         "Success Address : ${_pref.getString(GwcApi.successMemberAddress)}");
  //   }
  // }

  // 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

  saveData(String token, String chatUserName, String chatUserId,
      String kaleyraUserId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", token);
  }
}


//Consumer<MoviesListVM>(builder: (context, viewModel, _) {
//           switch (viewModel.movieMain.status) {
//             case Status.LOADING:
//               print("MARAJ :: LOADING");
//               return LoadingWidget();
//             case Status.ERROR:
//               print("MARAJ :: ERROR");
//               return MyErrorWidget(viewModel.movieMain.message ?? "NA");
//             case Status.COMPLETED:
//               print("MARAJ :: COMPLETED");
//               return _getMoviesListView(viewModel.movieMain.data?.movies);
//             default:
//           }
//           return Container();
//         }),
//       ),