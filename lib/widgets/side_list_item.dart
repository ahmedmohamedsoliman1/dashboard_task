import 'package:dashboard_task/core/app_colors.dart';
import 'package:dashboard_task/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget sideListItem ({
  required Widget secondWidget ,
  required String text ,
  required IconData icon ,
  required BuildContext context
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5.w),
    width: MediaQuery.of(context).size.width*0.2,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon , color: AppColors.blackColor, size: 15,),
            SizedBox(width: 2.w,),
            appText(text: text, color: AppColors.blackColor, fontSize: 14 ,
            fontWeight: FontWeight.w100),
          ],
        ),
        secondWidget
      ],
    ),
  );
}