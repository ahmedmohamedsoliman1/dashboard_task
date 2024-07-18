import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../features/dashboard/dashborad_view_model.dart';
import 'app_text.dart';

class ListViewItem extends StatefulWidget {
  final String firstTitle ;
  final String secongTitle ;
  final String thirdTitle ;
  final IconData icon ;
  final Color iconColor ;
  final Color color ;
  const ListViewItem({Key? key ,
  required this.firstTitle , required this.secongTitle ,
  required this.thirdTitle ,
  required this.icon , required this.iconColor ,
  required this.color}) : super(key: key);

  @override
  State<ListViewItem> createState() => _ListViewItemState();
}

class _ListViewItemState extends State<ListViewItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width*(0.77/3),
      height: 150.h,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText(
                      text: widget.firstTitle,
                      color: AppColors.greyColor,
                      fontSize: 18),
                  SizedBox(height: 10.h,),
                  appText(
                      text: widget.secongTitle,
                      color: AppColors.blackColor,
                      fontSize: 20),
                  SizedBox(height: 10.h,),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: widget.color ,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        padding: const EdgeInsets.all(5),
                        width: 20.w,
                        height: 35.h,
                        child: Center(
                          child: appText(
                              text: widget.thirdTitle,
                              color: Colors.white,
                              fontSize: 14),
                        ),
                      ),
                      SizedBox(width: 5.w,),
                      appText(
                          text: "Since last month",
                          color: AppColors.greyColor,
                          fontSize: 16)
                    ],
                  )
                ],
              ),
              Consumer<DashBoardViewModel>(
                  builder: (context , provider , _) {
                    return MouseRegion(
                      cursor: SystemMouseCursors.basic,
                      onEnter: (event){
                        provider.startBoxAnimationFun();
                      },
                      onExit: (event){
                       provider.endBoxAnimationFun();
                      },
                      child: AnimatedRotation(
                          turns: provider.turns,
                          duration: const Duration(milliseconds: 400),
                          child: Container(
                            decoration: BoxDecoration(
                                color: widget.iconColor,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            padding: const EdgeInsets.all(5),
                            child:  Icon(widget.icon, color: Colors.white,),
                          )),
                    );
                  })
            ],
          )
        ],
      ),
    );
  }
}
