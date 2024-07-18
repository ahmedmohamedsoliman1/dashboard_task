import 'package:dashboard_task/features/dashboard/dashborad_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_images.dart';
import '../../core/app_strings.dart';
import '../../widgets/app_text.dart';
import '../../widgets/side_list_item.dart';

class SideListWidget extends StatefulWidget {
  const SideListWidget({Key? key}) : super(key: key);

  @override
  State<SideListWidget> createState() => _SideListWidgetState();
}

class _SideListWidgetState extends State<SideListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.2,
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
                color: AppColors.blackColor.withOpacity(0.1),
                spreadRadius: 2 ,
                blurRadius: 2
            ),
          ]
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15.h,),
            Image(image: const AssetImage(AppImages.logo) ,
              width: 30.w,
              height: 50.h,) ,
            SizedBox(height: 15.h,),
            Consumer<DashBoardViewModel>(
                builder: (context , provider , _) {
                  if (provider.isUserInfoSwitchPressed == false){
                    return SizedBox();
                  }else {
                    return Container(
                      width: MediaQuery.of(context).size.width*0.2,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.blueDarkColor ,
                            AppColors.blueLightColor
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                        ),),
                      padding: EdgeInsets.symmetric(horizontal: 3.w , vertical: 15.h),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(AppImages.avatar),
                            backgroundColor: AppColors.primaryColor,
                          ) ,
                          SizedBox(width: 5.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              appText(
                                  text: AppStrings.doris,
                                  color: AppColors.whiteColor,
                                  fontSize: 14 ,
                                  fontWeight: FontWeight.bold) ,
                              SizedBox(height: 2.h,),
                              appText(
                                  text: AppStrings.founder,
                                  color: AppColors.whiteColor,
                                  fontSize: 12 ,
                                  fontWeight: FontWeight.normal)
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_right_outlined, size: 30, color: AppColors.whiteColor,)
                        ],
                      ),
                    ) ;
                  }
                }),
            SizedBox(height: 15.h,),
            Container(
              width: MediaQuery.of(context).size.width*0.2,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                children: [
                  appText(
                      text: AppStrings.main,
                      color: AppColors.greyColor,
                      fontSize: 14),
                ],
              ),
            ),
            SizedBox(height: 5.h,),
            sideListItem(
                secondWidget: Container(
                  width: 10.w,
                  height: 18.h,
                  decoration: BoxDecoration(
                      color: AppColors.greenColor ,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                      child: appText(
                      text: "9+",
                      color: AppColors.whiteColor,
                      fontSize: 10)),
                ),
                text: AppStrings.dashboard ,
            icon: Icons.data_saver_on ,
            context: context),
            SizedBox(height: 15.h,) ,
            sideListItem(
                secondWidget: const SizedBox(),
                text: AppStrings.calender ,
            icon: Icons.calendar_month ,
            context: context),
            SizedBox(height: 15.h,) ,
            sideListItem(
                secondWidget: const SizedBox(),
                text: AppStrings.chat ,
                icon: Icons.chat ,
            context: context),
            SizedBox(height: 15.h,) ,
            sideListItem(
                secondWidget: const Icon(Icons.arrow_right_outlined , color: AppColors.blackColor,),
                text: AppStrings.email ,
                icon: Icons.email ,
            context: context),
            SizedBox(height: 15.h,) ,
            sideListItem(
                secondWidget: const Icon(Icons.arrow_right_outlined , color: AppColors.blackColor,),
                text: AppStrings.tasks ,
                icon: Icons.format_list_bulleted ,
            context: context),
            SizedBox(height: 15.h,) ,
            sideListItem(
                secondWidget: const SizedBox(),
                text: AppStrings.kanbanBoard ,
                icon: Icons.departure_board ,
            context: context),
            SizedBox(height: 15.h) ,
            sideListItem(
                secondWidget: Container(
                  width: 10.w,
                  height: 18.h,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple ,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                      child: appText(
                          text: "1 File",
                          color: AppColors.whiteColor,
                          fontSize: 10)),
                ),
                text: AppStrings.fileManager ,
                icon: Icons.folder_copy ,
            context: context),
            SizedBox(height: 15.h,),
            Container(
              width: MediaQuery.of(context).size.width*0.2,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                children: [
                  appText(
                      text: AppStrings.custom,
                      color: AppColors.greyColor,
                      fontSize: 14),
                ],
              ),
            ),
            SizedBox(height: 15.h,),
            sideListItem(
                secondWidget: const Icon(Icons.arrow_right_outlined , color: AppColors.blackColor,),
                text: AppStrings.pages ,
                icon: Icons.restore_page_sharp ,
            context: context),
            SizedBox(height: 15.h,),
            sideListItem(
                secondWidget: const Icon(Icons.arrow_right_outlined , color: AppColors.blackColor,),
                text: AppStrings.authPages ,
                icon: Icons.person_add_alt_1_sharp ,
            context: context),
            SizedBox(height: 15.h,),
            sideListItem(
                secondWidget: const Icon(Icons.arrow_right_outlined , color: AppColors.blackColor,),
                text: AppStrings.errorPages ,
                icon: Icons.error ,
            context: context),
            SizedBox(height: 15.h,),
            sideListItem(
                secondWidget: const Icon(Icons.arrow_right_outlined , color: AppColors.blackColor,),
                text: AppStrings.layouts ,
                icon: Icons.layers_outlined ,
            context: context),
            SizedBox(height: 15.h,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              width: MediaQuery.of(context).size.width*0.2,
              child: Row(
                children: [
                  appText(
                      text: AppStrings.components,
                      color: AppColors.greyColor,
                      fontSize: 14),
                ],
              ),
            ),
            SizedBox(height: 15.h,),
            sideListItem(
                secondWidget: const Icon(Icons.arrow_right_outlined , color: AppColors.blackColor,),
                text: AppStrings.baseUi ,
                icon: Icons.shopping_bag_rounded,
            context: context),
            SizedBox(height: 15.h,),
            sideListItem(
                secondWidget: const Icon(Icons.arrow_right_outlined , color: AppColors.blackColor,),
                text: AppStrings.expandedUi ,
                icon: Icons.expand_rounded,
                context: context),
            SizedBox(height: 15.h,),
            sideListItem(
                secondWidget: const SizedBox(),
                text: AppStrings.widgets ,
                icon: Icons.widgets ,
            context: context),
            SizedBox(height: 15.h,),
            sideListItem(
                secondWidget: const Icon(Icons.arrow_right_outlined , color: AppColors.blackColor,),
                text: AppStrings.icons ,
                icon: Icons.import_contacts_sharp ,
            context: context),
            SizedBox(height: 15.h,),
            sideListItem(
                secondWidget: const Icon(Icons.arrow_right_outlined , color: AppColors.blackColor,),
                text: AppStrings.charts ,
                icon: Icons.add_chart_sharp ,
            context: context),
            SizedBox(height: 15.h,),
            sideListItem(
                secondWidget: const Icon(Icons.arrow_right_outlined , color: AppColors.blackColor,),
                text: AppStrings.forms ,
                icon: Icons.format_shapes ,
            context: context),
            SizedBox(height: 15.h,),
            sideListItem(
                secondWidget: const Icon(Icons.arrow_right_outlined , color: AppColors.blackColor,),
                text: AppStrings.tables ,
                icon: Icons.table_chart_outlined ,
            context: context),
            SizedBox(height: 15.h,),
            sideListItem(
                secondWidget: const Icon(Icons.arrow_right_outlined , color: AppColors.blackColor,),
                text: AppStrings.maps ,
                icon: Icons.map ,
            context: context),
            SizedBox(height: 15.h,),
            sideListItem(
                secondWidget: const Icon(Icons.arrow_right_outlined , color: AppColors.blackColor,),
                text: AppStrings.multiLevels ,
                icon: Icons.share ,
            context: context),
            SizedBox(height: 15.h,),
          ],
        ),
      ),
    );
  }
}
