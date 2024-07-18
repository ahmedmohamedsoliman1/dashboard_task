import 'package:dashboard_task/core/app_colors.dart';
import 'package:dashboard_task/core/app_images.dart';
import 'package:dashboard_task/features/dashboard/dashborad_view_model.dart';
import 'package:dashboard_task/widgets/app_text.dart';
import 'package:datetime_picker_field_platform/datetime_picker_field_platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../core/app_strings.dart';
import '../../models/language_model.dart';
import 'package:intl/intl.dart';

import '../../widgets/chart_widget.dart';

class MainBodyDashboardWidget extends StatefulWidget {
  
  final List<LanguageModel> languagesList ;
  final bool isMenuShow ;
  const MainBodyDashboardWidget({Key? key , required this.languagesList ,
  required this.isMenuShow}) : super(key: key);

  @override
  State<MainBodyDashboardWidget> createState() => _MainBodyDashboardWidgetState();
}

class _MainBodyDashboardWidgetState extends State<MainBodyDashboardWidget> {

  String mapTheme = "" ;
  bool themeDone = false ;

  @override
  void initState() {
    DefaultAssetBundle.of(context).loadString("assets/mapTheme/silver_theme.json").then((value) {
      mapTheme = value ;
      Provider.of<DashBoardViewModel>(context , listen: false).equalMapDone();
      Provider.of<DashBoardViewModel>(context , listen: false).addToMarkers();
      // Provider.of<DashBoardViewModel>(context , listen: false).addSecondMarker();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.79,
            height: 100.h,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.blackColor.withOpacity(0.1),
                  spreadRadius: 2 ,
                  blurRadius: 2 ,
                ),
              ]
            ),
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.filter_list, color: AppColors.blackColor,) ,
                    SizedBox(width: 5.w,),
                    SizedBox(
                      width: 50.w,
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color:AppColors.transparentColor),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColors.transparentColor),
                            ),

                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: AppColors.transparentColor),
                            ),
                            filled: true ,
                            fillColor: AppColors.greyColor100,
                            hintText: AppStrings.search ,
                            prefixIcon: const Icon(Icons.search , color: Colors.black38)
                        ),
                        onChanged: (input) {

                        },
                      ),
                    )
                  ],
                ) ,
                Row(
                  children: [
                    DropdownButton(
                      value: widget.languagesList.first,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: widget.languagesList.map((LanguageModel lan) {
                        return DropdownMenuItem(
                          value: lan,
                          child: Row(
                            children: [
                              SvgPicture.asset(lan.image ,
                              width: 10.w,
                              height: 10.h,) ,
                              SizedBox(width: 2.w,),
                              appText(
                                  text: lan.title,
                                  color: AppColors.blackColor,
                                  fontSize: 15)
                            ],
                          ),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (LanguageModel? newValue) {

                      },
                    ),
                    SizedBox(width: 5.w,),
                    const Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Icon(Icons.notification_important, color: AppColors.blackColor,),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.redColor,
                        )
                      ],
                    ),
                    SizedBox(width: 5.w,),
                    Consumer<DashBoardViewModel>(
                        builder: (context , provider , _){
                          return GestureDetector(
                              onLongPressStart: (details) async{
                                Provider.of<DashBoardViewModel>(context , listen: false).menuPressed();
                                if (provider.isMeniPressed){
                                  await showMenu(
                                    elevation: 5,
                                      context: context,
                                      position: RelativeRect.fromLTRB(
                                        details.globalPosition.dx,
                                        details.globalPosition.dy,
                                        MediaQuery.of(context).size.width - (details.globalPosition.dx),
                                        MediaQuery.of(context).size.height - (details.globalPosition.dy),
                                      ),
                                      items: [
                                        PopupMenuItem(child: Row(
                                          children: [
                                            Image(image: const AssetImage(AppImages.github) ,
                                            width: 20.w,
                                            height: 20.h,) ,
                                            SizedBox(width: 2.w,),
                                            appText(
                                                text: "Github",
                                                color: AppColors.blackColor,
                                                fontSize: 15)
                                          ],
                                        )),
                                        PopupMenuItem(child: Row(
                                          children: [
                                            Image(image: const AssetImage(AppImages.bitbucket) ,
                                            width: 20.w,
                                            height: 20.h,) ,
                                            SizedBox(width: 2.w,),
                                            appText(
                                                text: "Bitbucket",
                                                color: AppColors.blackColor,
                                                fontSize: 15)
                                          ],
                                        )),
                                        PopupMenuItem(child: Row(
                                          children: [
                                            Image(image: const AssetImage(AppImages.dropbox) ,
                                            width: 20.w,
                                            height: 20.h,) ,
                                            SizedBox(width: 2.w,),
                                            appText(
                                                text: "Dropbox",
                                                color: AppColors.blackColor,
                                                fontSize: 15)
                                          ],
                                        )),
                                        PopupMenuItem(child: Row(
                                          children: [
                                            Image(image: const AssetImage(AppImages.slack) ,
                                            width: 20.w,
                                            height: 20.h,) ,
                                            SizedBox(width: 2.w,),
                                            appText(
                                                text: "Slack",
                                                color: AppColors.blackColor,
                                                fontSize: 15)
                                          ],
                                        )),
                                        PopupMenuItem(child: Row(
                                          children: [
                                           Image(image: const AssetImage(AppImages.behance) ,
                                            width: 20.w,
                                            height: 20.h,) ,
                                            SizedBox(width: 2.w,),
                                            appText(
                                                text: "Behance",
                                                color: AppColors.blackColor,
                                                fontSize: 15)
                                          ],
                                        )),
                                      ]);
                                }

                              },
                              child: const Icon(Icons.apartment_sharp , color: AppColors.blackColor,));
                        }),
                     SizedBox(width: 5.w,),
                     InkWell(
                       onTap: () {
                         if (!Scaffold.of(context).isEndDrawerOpen){
                           Scaffold.of(context).openEndDrawer();
                         }
                       },
                         child: const Icon(Icons.settings , color: AppColors.blackColor,)),
                    SizedBox(width: 5.w,),
                    const Icon(Icons.brightness_2, color: AppColors.blackColor,),
                    SizedBox(width: 5.w,),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(AppImages.avatar),
                          backgroundColor: AppColors.primaryColor,
                        ) ,
                        SizedBox(width: 5.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            appText(
                                text: AppStrings.doris,
                                color: AppColors.blackColor,
                                fontSize: 14 ,
                                fontWeight: FontWeight.bold) ,
                            SizedBox(height: 2.h,),
                            appText(
                                text: AppStrings.founder,
                                color: AppColors.blackColor,
                                fontSize: 12 ,
                                fontWeight: FontWeight.normal)
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10.h,),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.79,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                appText(
                    text: AppStrings.dashboard,
                    color: AppColors.blackColor,
                    fontSize: 18),
               Row(
                 children: [
                   Consumer<DashBoardViewModel>(
                       builder: (context , provider , _) {
                         return  SizedBox(
                           width: 50.w,
                           height: 50.h,
                           child: DateTimeFieldPlatform (
                             onConfirm: (date){
                               provider.selectedToTime = date ;
                               setState(() {
                                 provider.selectedToTimeFormated = DateFormat.yMd().format(provider.selectedToTime!);
                               });
                             },
                             validator: (input){
                               if (input == null || input.trim().isEmpty){
                                 return "Please from (date) is required" ;
                               }else {
                                 return null ;
                               }
                             },
                             decoration: InputDecoration(
                                 border: InputBorder.none,
                                 filled: true,
                                 fillColor: Colors.white,
                                 hintText: DateFormat.yMd().format(provider.now),
                                 hintStyle: const TextStyle(
                                     color: Colors.black87 ,
                                     fontWeight: FontWeight.normal ,
                                     fontSize: 15
                                 )
                             ),
                             mode: DateMode.date,
                             maximumDate: DateTime.now().add(const Duration(days: 720)),
                             minimumDate: DateTime.utc(2009),),
                         );
                       }),
                   Container(
                     height: 50.h,
                     width: 15.w,
                     padding: EdgeInsets.all(5),
                     decoration: BoxDecoration(
                       color: Colors.indigo
                     ),
                     child: Center(
                       child: Icon(Icons.date_range , color: Colors.white,),
                     ),
                   ),
                 ],
               )
              ],
            ),
          ),
          SizedBox(height: 10.h,),
          Consumer<DashBoardViewModel>(
              builder: (context , provider , _) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width*0.79,
                  height: 150.h,
                  child: ListView.separated(
                    separatorBuilder: (context , index) {
                      return SizedBox(width: 2.w,);
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context , index) {
                      return provider.firstList[index] ;
                    },
                  ),
                ) ;
              }),
          SizedBox(height: 5.h,),
          Consumer<DashBoardViewModel>(
              builder: (context , provider , _) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width*0.79,
                  height: 150.h,
                  child: ListView.separated(
                    separatorBuilder: (context , index) {
                      return SizedBox(width: 2.w,);
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context , index) {
                      return provider.secondList[index] ;
                    },
                  ),
                ) ;
              }),
          SizedBox(height: 5.h,),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.79,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.3,
                  height: MediaQuery.of(context).size.height*0.9,
                  color: Colors.white,
                  padding:const  EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          appText(
                              text: "Total Sales",
                              color: AppColors.blackColor,
                              fontSize: 18),
                          Consumer<DashBoardViewModel>(
                              builder: (context , provider , _) {
                                return  GestureDetector(
                                    onLongPressStart: (details) async{
                                      provider.totalSalesMenuPressed();
                                      if (provider.isTotalSalesMenuPressed){
                                        await showMenu(
                                            context: context,
                                            position: RelativeRect.fromLTRB(
                                              details.globalPosition.dx,
                                              details.globalPosition.dy,
                                              MediaQuery.of(context).size.width - (details.globalPosition.dx),
                                              MediaQuery.of(context).size.height - (details.globalPosition.dy),
                                            ),
                                            items: [
                                              const PopupMenuItem(child: Text("Sales Report")),
                                              const PopupMenuItem(child: Text("Export Report")),
                                              const PopupMenuItem(child: Text("Profit")),
                                              const PopupMenuItem(child: Text("Action"))
                                            ]);
                                      }
                                    },
                                    child: const Icon(Icons.menu , color: AppColors.blackColor,));
                              }
                          )
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      CircularPercentIndicator(
                        radius: 120.0,
                        lineWidth: 20.0,
                        animation: true,
                        backgroundColor: Colors.grey.shade100,
                        percent: 0.7,
                        center:  const Text(
                          "67%",
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        footer:  const Text(
                          "Returning Customer",
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0 ,
                              color: Colors.indigo),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.indigo,
                      ),
                      SizedBox(height: 20.h,),
                      Row(
                        children: [
                          appText(
                              text: "Brookly , New York",
                              color: AppColors.blackColor,
                              fontSize: 16),
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width*0.2,
                            lineHeight: 10.0,
                            percent: 0.7,
                            barRadius: const Radius.circular(10),
                            backgroundColor: Colors.grey.shade100,
                            progressColor: Colors.indigo,
                          ),
                          appText(
                              text: "72 K",
                              color: AppColors.blackColor,
                              fontSize: 16 ,
                              fontWeight: FontWeight.bold)
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        children: [
                          appText(
                              text: "The Castro, San Francisco",
                              color: AppColors.blackColor,
                              fontSize: 16),
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width*0.2,
                            lineHeight: 10.0,
                            percent: 0.4,
                            barRadius: const Radius.circular(10),
                            backgroundColor: Colors.grey.shade100,
                            progressColor: Colors.indigo,
                          ),
                          appText(
                              text: "39 K",
                              color: AppColors.blackColor,
                              fontSize: 16 ,
                              fontWeight: FontWeight.bold)
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        children: [
                          appText(
                              text: "Kovan, Singapore",
                              color: AppColors.blackColor,
                              fontSize: 16),
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width*0.2,
                            lineHeight: 10.0,
                            percent: 0.5,
                            barRadius: const Radius.circular(10),
                            backgroundColor: Colors.grey.shade100,
                            progressColor: Colors.indigo,
                          ),
                          appText(
                              text: "61 K",
                              color: AppColors.blackColor,
                              fontSize: 16 ,
                              fontWeight: FontWeight.bold)
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(width: 2.w,),
                Container(
                  width: MediaQuery.of(context).size.width*0.48,
                  height: MediaQuery.of(context).size.height*0.9,
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          appText(
                              text: "Revenue",
                              color: AppColors.blackColor,
                              fontSize: 18),
                          Consumer<DashBoardViewModel>(
                              builder: (context , provider , _) {
                                return  GestureDetector(
                                    onLongPressStart: (details) async{
                                      provider.totalSalesMenuPressed();
                                      if (provider.isTotalSalesMenuPressed){
                                        await showMenu(
                                            context: context,
                                            position: RelativeRect.fromLTRB(
                                              details.globalPosition.dx,
                                              details.globalPosition.dy,
                                              MediaQuery.of(context).size.width - (details.globalPosition.dx),
                                              MediaQuery.of(context).size.height - (details.globalPosition.dy),
                                            ),
                                            items: [
                                              const PopupMenuItem(child: Text("Sales Report")),
                                              const PopupMenuItem(child: Text("Export Report")),
                                              const PopupMenuItem(child: Text("Profit")),
                                              const PopupMenuItem(child: Text("Action"))
                                            ]);
                                      }
                                    },
                                    child: const Icon(Icons.menu , color: AppColors.blackColor,));
                              }
                          )
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      Container(
                        color: Colors.grey.shade100,
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                appText(
                                    text: "Current week",
                                    color: AppColors.greyColor,
                                    fontSize: 16),
                                SizedBox(height: 5.h,),
                                appText(
                                    text: "\$ 1705.54",
                                    color: AppColors.blackColor,
                                    fontSize: 16)
                              ],
                            ) ,
                            Column(
                              children: [
                                appText(
                                    text: "Previous  week",
                                    color: AppColors.greyColor,
                                    fontSize: 16),
                                SizedBox(height: 5.h,),
                                Row(
                                  children: [
                                    appText(
                                        text: "\$ 6.523.25",
                                        color: AppColors.blackColor,
                                        fontSize: 16),
                                    SizedBox(width: 1.w,),
                                    const Icon(Icons.arrow_upward , color: Colors.green,)
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                appText(
                                    text: "Conversation",
                                    color: AppColors.greyColor,
                                    fontSize: 16),
                                SizedBox(height: 5.h,),
                                appText(
                                    text: "8.27 %",
                                    color: AppColors.blackColor,
                                    fontSize: 16)
                              ],
                            ) ,
                            Column(
                              children: [
                                appText(
                                    text: "Customers",
                                    color: AppColors.greyColor,
                                    fontSize: 16),
                                SizedBox(height: 5.h,),
                                Row(
                                  children: [
                                    appText(
                                        text: "69 K",
                                        color: AppColors.blackColor,
                                        fontSize: 16),
                                    SizedBox(width: 1.w,),
                                    const Icon(Icons.arrow_downward_sharp , color: Colors.red,)
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      LineChartSample4()
                    ],
                  ),
                )
              ],
            ),
          ) ,
          SizedBox(height: 5.h,),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.79,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.5,
                  height: MediaQuery.of(context).size.height*0.8,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.5,
                        color: Colors.white,
                        padding:const  EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            appText(
                                text: "Revenue By Locations",
                                color: AppColors.blackColor,
                                fontSize: 18),
                            Consumer<DashBoardViewModel>(
                                builder: (context , provider , _) {
                                  return  GestureDetector(
                                      onLongPressStart: (details) async{
                                        provider.totalSalesMenuPressed();
                                        if (provider.isTotalSalesMenuPressed){
                                          await showMenu(
                                              context: context,
                                              position: RelativeRect.fromLTRB(
                                                details.globalPosition.dx,
                                                details.globalPosition.dy,
                                                MediaQuery.of(context).size.width - (details.globalPosition.dx),
                                                MediaQuery.of(context).size.height - (details.globalPosition.dy),
                                              ),
                                              items: [
                                                const PopupMenuItem(child: Text("Sales Report")),
                                                const PopupMenuItem(child: Text("Export Report")),
                                                const PopupMenuItem(child: Text("Profit")),
                                                const PopupMenuItem(child: Text("Action"))
                                              ]);
                                        }
                                      },
                                      child: const Icon(Icons.menu , color: AppColors.blackColor,));
                                }
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Consumer<DashBoardViewModel>(
                              builder: (context , provider , _) {
                                if (provider.themeDone){
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width*0.5,
                                    height: MediaQuery.of(context).size.height*0.6,
                                    child: Opacity(
                                      opacity: 0.5,
                                      child: GoogleMap(
                                        initialCameraPosition: provider.mainPosition,
                                        markers: provider.markers,
                                        mapType: MapType.normal,
                                        onMapCreated: (controller){
                                          provider.mainController.complete(controller);
                                          controller.setMapStyle(mapTheme).then((value){
                                            setState(() {
                                            });
                                          });
                                          provider.equalMapController(controller);
                                          controller.animateCamera(
                                              CameraUpdate.newCameraPosition(CameraPosition(
                                                  target: provider.mainPosition.target)));
                                        },
                                      ),
                                    ),
                                  );
                                }else {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width*0.5,
                                    height: MediaQuery.of(context).size.height*0.6,
                                  );
                                }
                              }),
                          Positioned(
                            right: 30,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    appText(
                                        text: "India",
                                        color: AppColors.greyColor,
                                        fontSize: 11 ,
                                    fontWeight: FontWeight.bold) ,
                                    SizedBox(width: 2.w),
                                    LinearPercentIndicator(
                                      animation: true,
                                      width: MediaQuery.of(context).size.width*0.1,
                                      lineHeight: 20.0,
                                      percent: 0.7,
                                      barRadius: const Radius.circular(2),
                                      backgroundColor: Colors.transparent,
                                      progressColor: Colors.green,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  children: [
                                    appText(
                                        text: "South Kores",
                                        color: AppColors.greyColor,
                                        fontSize: 11 ,
                                        fontWeight: FontWeight.bold) ,
                                    SizedBox(width: 2.w),
                                    LinearPercentIndicator(
                                      animation: true,
                                      width: MediaQuery.of(context).size.width*0.1,
                                      lineHeight: 20.0,
                                      percent: 0.65,
                                      barRadius: const Radius.circular(2),
                                      backgroundColor: Colors.transparent,
                                      progressColor: Colors.green,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  children: [
                                    appText(
                                        text: "China",
                                        color: AppColors.greyColor,
                                        fontSize: 11 ,
                                        fontWeight: FontWeight.bold) ,
                                    SizedBox(width: 2.w),
                                    LinearPercentIndicator(
                                      animation: true,
                                      width: MediaQuery.of(context).size.width*0.1,
                                      lineHeight: 20.0,
                                      percent: 0.6,
                                      barRadius: const Radius.circular(2),
                                      backgroundColor: Colors.transparent,
                                      progressColor: Colors.green,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  children: [
                                    appText(
                                        text: "United Kingdom",
                                        color: AppColors.greyColor,
                                        fontSize: 11 ,
                                        fontWeight: FontWeight.bold) ,
                                    SizedBox(width: 2.w),
                                    LinearPercentIndicator(
                                      animation: true,
                                      width: MediaQuery.of(context).size.width*0.1,
                                      lineHeight: 20.0,
                                      percent: 0.55,
                                      barRadius: const Radius.circular(2),
                                      backgroundColor: Colors.transparent,
                                      progressColor: Colors.green,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  children: [
                                    appText(
                                        text: "Japan",
                                        color: AppColors.greyColor,
                                        fontSize: 11 ,
                                        fontWeight: FontWeight.bold) ,
                                    SizedBox(width: 2.w),
                                    LinearPercentIndicator(
                                      animation: true,
                                      width: MediaQuery.of(context).size.width*0.1,
                                      lineHeight: 20.0,
                                      percent: 0.5,
                                      barRadius: const Radius.circular(2),
                                      backgroundColor: Colors.transparent,
                                      progressColor: Colors.green,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  children: [
                                    appText(
                                        text: "Italy",
                                        color: AppColors.greyColor,
                                        fontSize: 11 ,
                                        fontWeight: FontWeight.bold) ,
                                    SizedBox(width: 2.w),
                                    LinearPercentIndicator(
                                      animation: true,
                                      width: MediaQuery.of(context).size.width*0.1,
                                      lineHeight: 20.0,
                                      percent: 0.3,
                                      barRadius: const Radius.circular(2),
                                      backgroundColor: Colors.transparent,
                                      progressColor: Colors.green,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  children: [
                                    appText(
                                        text: "Canada",
                                        color: AppColors.greyColor,
                                        fontSize: 11 ,
                                        fontWeight: FontWeight.bold) ,
                                    SizedBox(width: 2.w),
                                    LinearPercentIndicator(
                                      animation: true,
                                      width: MediaQuery.of(context).size.width*0.1,
                                      lineHeight: 20.0,
                                      percent: 0.2,
                                      barRadius: const Radius.circular(2),
                                      backgroundColor: Colors.transparent,
                                      progressColor: Colors.green,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  children: [
                                    appText(
                                        text: "United States",
                                        color: AppColors.greyColor,
                                        fontSize: 11 ,
                                        fontWeight: FontWeight.bold) ,
                                    SizedBox(width: 2.w),
                                    LinearPercentIndicator(
                                      animation: true,
                                      width: MediaQuery.of(context).size.width*0.1,
                                      lineHeight: 20.0,
                                      percent: 0.1,
                                      barRadius: const Radius.circular(2),
                                      backgroundColor: Colors.transparent,
                                      progressColor: Colors.green,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
                SizedBox(width: 2.w,),
                Container(
                  width: MediaQuery.of(context).size.width*0.26,
                  height: MediaQuery.of(context).size.height*0.8,
                  color : Colors.white,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.5,
                        color: Colors.white,
                        padding:const  EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            appText(
                                text: "Top Selling Products",
                                color: AppColors.blackColor,
                                fontSize: 18),
                            Consumer<DashBoardViewModel>(
                                builder: (context , provider , _) {
                                  return  ElevatedButton(
                                      onPressed: () {

                                      },
                                    style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                    )
                                    ),
                                      child: Row(
                                        children: [
                                          appText(text: "Export", color: Colors.white, fontSize: 15),
                                          SizedBox(width: 2.w,),
                                          const Icon(Icons.download , color: Colors.white,)
                                        ],
                                      ) ,);
                                }
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.5,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            dividerThickness: 0,
                            border: const TableBorder.symmetric(
                              outside: BorderSide.none,
                              inside: BorderSide(width: 1, color: Colors.grey, style: BorderStyle.solid),
                            ),
                              headingRowColor:
                              WidgetStateColor.resolveWith((states) => AppColors.greyColor100),
                              columns: const [
                                DataColumn(label: Text("Products")),
                                DataColumn(label: Text("Price")),
                                DataColumn(label: Text("Orders")),
                                DataColumn(label: Text("Avl.Quantity")),
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Text("ASOS Ridley High Waist")),
                                  DataCell(Text("\$79.49")),
                                  DataCell(Text("82")),
                                  DataCell(Text("8.540")),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Marco Lightweight Shirt")),
                                  DataCell(Text("\$12.5")),
                                  DataCell(Text("58")),
                                  DataCell(Text("3.270")),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Half Sleeve Shirt")),
                                  DataCell(Text("\$9.99")),
                                  DataCell(Text("254")),
                                  DataCell(Text("10.258")),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Lightweight Jacket")),
                                  DataCell(Text("\$69.99")),
                                  DataCell(Text("560")),
                                  DataCell(Text("1.020")),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Marco Sport Shoes")),
                                  DataCell(Text("\$119.99")),
                                  DataCell(Text("75")),
                                  DataCell(Text("357")),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Custom Women's T-shirts")),
                                  DataCell(Text("\$45.00")),
                                  DataCell(Text("85")),
                                  DataCell(Text("135")),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Marco Sport Shoes")),
                                  DataCell(Text("\$119.99")),
                                  DataCell(Text("75")),
                                  DataCell(Text("357")),
                                ]),
                              ]),


                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 5.h,),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.79,
            height: MediaQuery.of(context).size.height*0.6,
            child: Row(
              children: [
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width*(0.76/3),
                  height: MediaQuery.of(context).size.height*0.6,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*(0.76/3),
                        color: Colors.white,
                        padding:const  EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            appText(
                                text: "Channels",
                                color: AppColors.blackColor,
                                fontSize: 15),
                            Consumer<DashBoardViewModel>(
                                builder: (context , provider , _) {
                                  return  ElevatedButton(
                                    onPressed: () {

                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5)
                                        )
                                    ),
                                    child: Row(
                                      children: [
                                        appText(text: "Export", color: Colors.white, fontSize: 15),
                                        SizedBox(width: 2.w,),
                                        const Icon(Icons.download , color: Colors.white,)
                                      ],
                                    ) ,);
                                }
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*(0.72/3),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                              dividerThickness: 0,
                              border: const TableBorder.symmetric(
                                outside: BorderSide.none,
                                inside: BorderSide(width: 1, color: Colors.grey, style: BorderStyle.solid),
                              ),
                              headingRowColor:
                              WidgetStateColor.resolveWith((states) => AppColors.greyColor100),
                              columns: const [
                                DataColumn(label: Text("Channels")),
                                DataColumn(label: Text("Visits")),
                                DataColumn(label: Text("Progress")),
                              ],
                              rows: [
                                DataRow(cells: [
                                  const DataCell(Text("Direct" ,
                                  style: TextStyle(
                                    fontSize: 12
                                  ),)),
                                  const DataCell(Text("2.050" ,
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  DataCell(LinearPercentIndicator(
                                    width: MediaQuery.of(context).size.width*0.05,
                                    lineHeight: 4.0,
                                    percent: 0.7,
                                    barRadius: const Radius.circular(10),
                                    backgroundColor: Colors.grey.shade100,
                                    progressColor: Colors.indigo,
                                  ),),

                                ]),
                                DataRow(cells: [
                                  const DataCell(Text("Organic Search",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  const DataCell(Text("1.405",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  DataCell(LinearPercentIndicator(
                                    width: MediaQuery.of(context).size.width*0.05,
                                    lineHeight: 4.0,
                                    percent: 0.5,
                                    barRadius: const Radius.circular(10),
                                    backgroundColor: Colors.grey.shade100,
                                    progressColor: Colors.blue,
                                  )),

                                ]),
                                DataRow(cells: [
                                  const DataCell(Text("Refferal",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  const DataCell(Text("750",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  DataCell(LinearPercentIndicator(
                                    width: MediaQuery.of(context).size.width*0.05,
                                    lineHeight: 4.0,
                                    percent: 0.4,
                                    barRadius: const Radius.circular(10),
                                    backgroundColor: Colors.grey.shade100,
                                    progressColor: Colors.yellow,
                                  )),

                                ]),
                                DataRow(cells: [
                                  const DataCell(Text("Social",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  const DataCell(Text("540",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  DataCell(LinearPercentIndicator(
                                    width: MediaQuery.of(context).size.width*0.05,
                                    lineHeight: 4.0,
                                    percent: 0.3,
                                    barRadius: const Radius.circular(10),
                                    backgroundColor: Colors.grey.shade100,
                                    progressColor: Colors.red,
                                  )),

                                ]),
                                DataRow(cells: [
                                  const DataCell(Text("Others",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  const DataCell(Text("119.99",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  DataCell(LinearPercentIndicator(
                                    width: MediaQuery.of(context).size.width*0.05,
                                    lineHeight: 4.0,
                                    percent: 0.2,
                                    barRadius: const Radius.circular(10),
                                    backgroundColor: Colors.grey.shade100,
                                    progressColor: Colors.green,
                                  )),

                                ]),
                              ]),


                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 2.w,),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width*(0.76/3),
                  height: MediaQuery.of(context).size.height*0.6,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*(0.76/3),
                        color: Colors.white,
                        padding:const  EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            appText(
                                text: "Social Media Traffic",
                                color: AppColors.blackColor,
                                fontSize: 15),
                            Consumer<DashBoardViewModel>(
                                builder: (context , provider , _) {
                                  return  ElevatedButton(
                                    onPressed: () {

                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5)
                                        )
                                    ),
                                    child: Row(
                                      children: [
                                        appText(text: "Export", color: Colors.white, fontSize: 15),
                                        SizedBox(width: 2.w,),
                                        const Icon(Icons.download , color: Colors.white,)
                                      ],
                                    ) ,);
                                }
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*(0.72/3),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                              dividerThickness: 0,
                              border: const TableBorder.symmetric(
                                outside: BorderSide.none,
                                inside: BorderSide(width: 1, color: Colors.grey, style: BorderStyle.solid),
                              ),
                              headingRowColor:
                              WidgetStateColor.resolveWith((states) => AppColors.greyColor100),
                              columns: const [
                                DataColumn(label: Text("Network")),
                                DataColumn(label: Text("Visits")),
                                DataColumn(label: Text("Progress")),
                              ],
                              rows: [
                                DataRow(cells: [
                                  const DataCell(Text("Facebook" ,
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  const DataCell(Text("2.250" ,
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  DataCell(LinearPercentIndicator(
                                    width: MediaQuery.of(context).size.width*0.05,
                                    lineHeight: 4.0,
                                    percent: 0.8,
                                    barRadius: const Radius.circular(10),
                                    backgroundColor: Colors.grey.shade100,
                                    progressColor: Colors.indigo,
                                  ),),

                                ]),
                                DataRow(cells: [
                                  const DataCell(Text("Instagram",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  const DataCell(Text("1.501",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  DataCell(LinearPercentIndicator(
                                    width: MediaQuery.of(context).size.width*0.05,
                                    lineHeight: 4.0,
                                    percent: 0.5,
                                    barRadius: const Radius.circular(10),
                                    backgroundColor: Colors.grey.shade100,
                                    progressColor: Colors.indigo,
                                  )),

                                ]),
                                DataRow(cells: [
                                  const DataCell(Text("Twitter",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  const DataCell(Text("750",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  DataCell(LinearPercentIndicator(
                                    width: MediaQuery.of(context).size.width*0.05,
                                    lineHeight: 4.0,
                                    percent: 0.4,
                                    barRadius: const Radius.circular(10),
                                    backgroundColor: Colors.grey.shade100,
                                    progressColor: Colors.indigo,
                                  )),

                                ]),
                                DataRow(cells: [
                                  const DataCell(Text("Linkedin",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  const DataCell(Text("540",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  DataCell(LinearPercentIndicator(
                                    width: MediaQuery.of(context).size.width*0.05,
                                    lineHeight: 4.0,
                                    percent: 0.3,
                                    barRadius: const Radius.circular(10),
                                    backgroundColor: Colors.grey.shade100,
                                    progressColor: Colors.indigo,
                                  )),

                                ]),
                                DataRow(cells: [
                                  const DataCell(Text("Others",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  const DataCell(Text("13.581",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  DataCell(LinearPercentIndicator(
                                    width: MediaQuery.of(context).size.width*0.05,
                                    lineHeight: 4.0,
                                    percent: 0.6,
                                    barRadius: const Radius.circular(10),
                                    backgroundColor: Colors.grey.shade100,
                                    progressColor: Colors.indigo,
                                  )),

                                ]),
                              ]),


                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 2.w,),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width*(0.76/3),
                  height: MediaQuery.of(context).size.height*0.6,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*(0.76/3),
                        color: Colors.white,
                        padding:const  EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            appText(
                                text: "Engagement Overview",
                                color: AppColors.blackColor,
                                fontSize: 15),
                            Consumer<DashBoardViewModel>(
                                builder: (context , provider , _) {
                                  return  ElevatedButton(
                                    onPressed: () {

                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5)
                                        )
                                    ),
                                    child: Row(
                                      children: [
                                        appText(text: "Export", color: Colors.white, fontSize: 15),
                                        SizedBox(width: 2.w,),
                                        const Icon(Icons.download , color: Colors.white,)
                                      ],
                                    ) ,);
                                }
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*(0.72/3),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                              dividerThickness: 0,
                              border: const TableBorder.symmetric(
                                outside: BorderSide.none,
                                inside: BorderSide(width: 1, color: Colors.grey, style: BorderStyle.solid),
                              ),
                              headingRowColor:
                              WidgetStateColor.resolveWith((states) => AppColors.greyColor100),
                              columns: const [
                                DataColumn(label: Text("Duration (Secs)")),
                                DataColumn(label: Text("Sessions")),
                                DataColumn(label: Text("Views")),
                              ],
                              rows: const [
                                DataRow(cells: [
                                  DataCell(Text("0 - 30" ,
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  DataCell(Text("2.250" ,
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  DataCell(Text("4.250")),

                                ]),
                                DataRow(cells: [
                                  DataCell(Text("31 - 60",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  DataCell(Text("1.501",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  DataCell(Text("1.050")),

                                ]),
                                DataRow(cells: [
                                  DataCell(Text("61 - 120",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  DataCell(Text("750",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  DataCell(Text("1.600")),

                                ]),
                                DataRow(cells: [
                                  DataCell(Text("121 - 240",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  DataCell(Text("540",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  DataCell(Text("1.040")),

                                ]),
                                DataRow(cells: [
                                 DataCell(Text("241 - 420",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                 DataCell(Text("56",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),)),
                                  DataCell(Text("886")),

                                ]),
                              ]),


                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ),
          SizedBox(height: 20.h,),
        ],
      ),
    );
  }
}
