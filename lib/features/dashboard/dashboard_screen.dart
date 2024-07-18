import 'package:dashboard_task/core/app_colors.dart';
import 'package:dashboard_task/features/dashboard/dashborad_navogator.dart';
import 'package:dashboard_task/features/dashboard/dashborad_view_model.dart';
import 'package:dashboard_task/features/dashboard/main_body_dashboard_widget.dart';
import 'package:dashboard_task/features/dashboard/side_list_widget.dart';
import 'package:dashboard_task/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../core/app_strings.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> with
SingleTickerProviderStateMixin implements DashBoardNavigator{

  DashBoardViewModel viewModel = DashBoardViewModel();

  @override
  void initState() {
    viewModel.navigator = this ;
    viewModel.controller = AnimationController(
        vsync: this ,
      duration: const Duration(milliseconds: 5000),);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => viewModel ,
    child: SafeArea(
      child: Scaffold(
        key: viewModel.scaffoldKey,
        endDrawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.indigo,
                  height: 80.h,
                  width: double.infinity,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        appText(
                            text: AppStrings.themeSettings,
                            color: Colors.white,
                            fontSize: 18 ,
                            fontWeight: FontWeight.bold),
                        InkWell(
                          onTap: () {
                            if (viewModel.scaffoldKey.currentState!.isEndDrawerOpen){
                              viewModel.scaffoldKey.currentState!.closeEndDrawer();
                            }
                          },
                            child: const Icon(Icons.close, color: Colors.white,)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: double.infinity,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: appText(
                          text: "Customize the overall color scheme, sidebar menu, etc",
                          color: AppColors.blackColor,
                          fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: [
                      appText(
                          text: AppStrings.chooseLayout,
                          color: Colors.black,
                          fontSize: 18),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
                Consumer<DashBoardViewModel>(
                    builder: (context , provider , _) {
                      return Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 8.w),
                        child: Row(
                          children: [
                            FlutterSwitch(
                              activeColor: Colors.indigo,
                              width: 45.0,
                              height: 20.0,
                              toggleSize: 20.0,
                              value: provider.isVerticalSwitchPressed,
                              borderRadius: 30.0,
                              onToggle: (val) {
                                provider.equalVerticalSwitch(val);
                                },
                            ),
                            SizedBox(width: 2.w,),
                            appText(
                                text: AppStrings.vertical,
                                color: AppColors.blackColor,
                                fontSize: 14)
                          ],
                        ),
                      );
                    }),
                SizedBox(height: 5.h,),
                Consumer<DashBoardViewModel>(
                    builder: (context , provider , _) {
                      return Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 8.w),
                        child: Row(
                          children: [
                            FlutterSwitch(
                              activeColor: Colors.indigo,
                              width: 45.0,
                              height: 20.0,
                              toggleSize: 20.0,
                              value: provider.isHorizontalSwitchPressed,
                              borderRadius: 30.0,
                              onToggle: (val) {
                                provider.equalHorizontalSwitch(val);
                              },
                            ),
                            SizedBox(width: 2.w,),
                            appText(
                                text: AppStrings.horizontal,
                                color: AppColors.blackColor,
                                fontSize: 14)
                          ],
                        ),
                      );
                    }),
                SizedBox(height: 20.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: [
                      appText(
                          text: AppStrings.colorTheme,
                          color: Colors.black,
                          fontSize: 18),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
                Consumer<DashBoardViewModel>(
                    builder: (context , provider , _) {
                      return Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 8.w),
                        child: Row(
                          children: [
                            FlutterSwitch(
                              activeColor: Colors.indigo,
                              width: 45.0,
                              height: 20.0,
                              toggleSize: 20.0,
                              value: provider.isLightSwitchPressed,
                              borderRadius: 30.0,
                              onToggle: (val) {
                                provider.equalLightSwitch(val);
                              },
                            ),
                            SizedBox(width: 2.w,),
                            appText(
                                text: AppStrings.light,
                                color: AppColors.blackColor,
                                fontSize: 14)
                          ],
                        ),
                      );
                    }),
                SizedBox(height: 5.h,),
                Consumer<DashBoardViewModel>(
                    builder: (context , provider , _) {
                      return Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 8.w),
                        child: Row(
                          children: [
                            FlutterSwitch(
                              activeColor: Colors.indigo,
                              width: 45.0,
                              height: 20.0,
                              toggleSize: 20.0,
                              value: provider.isDarkSwitchPressed,
                              borderRadius: 30.0,
                              onToggle: (val) {
                                provider.equalDarkSwitch(val);
                              },
                            ),
                            SizedBox(width: 2.w,),
                            appText(
                                text: AppStrings.dark,
                                color: AppColors.blackColor,
                                fontSize: 16)
                          ],
                        ),
                      );
                    }),
                SizedBox(height: 20.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: [
                      appText(
                          text: AppStrings.colorTheme,
                          color: Colors.black,
                          fontSize: 18),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
                Consumer<DashBoardViewModel>(
                    builder: (context , provider , _) {
                      return Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 8.w),
                        child: Row(
                          children: [
                            FlutterSwitch(
                              activeColor: Colors.indigo,
                              width: 45.0,
                              height: 20.0,
                              toggleSize: 20.0,
                              value: provider.isFluidSwitchPressed,
                              borderRadius: 30.0,
                              onToggle: (val) {
                                provider.equalFluidSwitch(val);
                                },
                            ),
                            SizedBox(width: 2.w,),
                            appText(
                                text: AppStrings.fluid,
                                color: AppColors.blackColor,
                                fontSize: 16)
                          ],
                        ),
                      );
                    }),
                SizedBox(height: 5.h,),
                Consumer<DashBoardViewModel>(
                    builder: (context , provider , _) {
                      return Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 8.w),
                        child: Row(
                          children: [
                            FlutterSwitch(
                              activeColor: Colors.indigo,
                              width: 45.0,
                              height: 20.0,
                              toggleSize: 20.0,
                              value: provider.isBoxedSwitchPressed,
                              borderRadius: 30.0,
                              onToggle: (val) {
                                provider.equalBoxedSwitch(val);
                                },
                            ),
                            SizedBox(width: 2.w,),
                            appText(
                                text: AppStrings.boxed,
                                color: AppColors.blackColor,
                                fontSize: 16)
                          ],
                        ),
                      );
                    }),
                SizedBox(height: 5.h,),
                Consumer<DashBoardViewModel>(
                    builder: (context , provider , _) {
                      return Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 8.w),
                        child: Row(
                          children: [
                            FlutterSwitch(
                              activeColor: Colors.indigo,
                              width: 45.0,
                              height: 20.0,
                              toggleSize: 20.0,
                              value: provider.isDetachedSwitchPressed,
                              borderRadius: 30.0,
                              onToggle: (val) {
                                provider.equalDetachedSwitch(val);
                              },
                            ),
                            SizedBox(width: 2.w,),
                            appText(
                                text: AppStrings.detached,
                                color: AppColors.blackColor,
                                fontSize: 16)
                          ],
                        ),
                      );
                    }),
                SizedBox(height: 20.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: [
                      appText(
                          text: AppStrings.layoutPosition,
                          color: Colors.black,
                          fontSize: 18),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
                ToggleSwitch(
                  minWidth: 90.0,
                  initialLabelIndex: 1,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  labels: const ['Fixed', 'Scrollable'],
                  activeBgColors: const [[Colors.indigo] , [Colors.indigo]],
                  onToggle: (index) {
                  },
                ),
                SizedBox(height: 20.h,),
                Consumer<DashBoardViewModel>(
                    builder: (context , provider , _) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            appText(
                                text: AppStrings.sidebarUserInfo,
                                color: Colors.black,
                                fontSize: 18),
                            FlutterSwitch(
                              activeColor: Colors.indigo,
                              width: 45.0,
                              height: 20.0,
                              toggleSize: 20.0,
                              value: provider.isUserInfoSwitchPressed,
                              borderRadius: 30.0,
                              onToggle: (val) {
                                provider.equalUserInfoSwitch(val);
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                SizedBox(height: 30.h,),
              ],
            ),
          ),
        ),
        body: Row(
          children: [
           const  SideListWidget(),
            SizedBox(width: 2.w,),
           MainBodyDashboardWidget(languagesList: viewModel.languageLists,
           isMenuShow: viewModel.isMeniPressed,)
          ],
        ),
      ),
    ),);
  }
}
