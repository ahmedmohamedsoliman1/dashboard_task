import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/language_model.dart';
import '../../widgets/list_view_item.dart';
import 'dashborad_navogator.dart';

class DashBoardViewModel extends ChangeNotifier {
  late DashBoardNavigator navigator ;

  List<LanguageModel> languageLists = [
    LanguageModel(image: "assets/images/english.svg", title: "English") ,
    LanguageModel(image: "assets/images/german.svg", title: "German") ,
    LanguageModel(image: "assets/images/italian.svg", title: "Italian") ,
  ] ;

  bool isMeniPressed = false ;
  bool isVerticalSwitchPressed = false ;
  bool isHorizontalSwitchPressed = false ;
  bool isLightSwitchPressed = false ;
  bool isDarkSwitchPressed = false ;
  bool isFluidSwitchPressed = false ;
  bool isBoxedSwitchPressed = false ;
  bool isDetachedSwitchPressed = false ;
  bool isUserInfoSwitchPressed = true ;

  bool isTotalSalesMenuPressed = false ;

  DateTime? selectedToTime ;
  String? selectedToTimeFormated ;
  DateTime now = DateTime.now();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  late AnimationController controller ;

  List <ListViewItem> firstList = [
    const ListViewItem(
        firstTitle: "CUSTOMERS",
        secongTitle: "54.214",
        thirdTitle: "↑ 2.541",
        icon: Icons.group,
        iconColor: Colors.green ,
    color: Colors.green,),
    const ListViewItem(
        firstTitle: "ORDERS",
        secongTitle: "7,543",
        thirdTitle: "↓ 1.08",
        icon: Icons.shopping_bag,
        iconColor: Colors.blue ,
    color: Colors.red,),
    const ListViewItem(
        firstTitle: "REVENUE",
        secongTitle: "\$9,254",
        thirdTitle: "↓ 7.00",
        icon: Icons.reviews,
        iconColor: Colors.red ,
    color: Colors.red,),

  ] ;

  List <ListViewItem> secondList = [
    const ListViewItem(
      firstTitle: "GROWTH",
      secongTitle: "+ 20.6 %",
      thirdTitle: "↑ 4.81",
      icon: Icons.circle_outlined,
      iconColor: Colors.indigo ,
      color: Colors.green,),
    const ListViewItem(
      firstTitle: "CONVERSATION",
      secongTitle: "9.62 %",
      thirdTitle: "↑ 3.07",
      icon: Icons.rate_review,
      iconColor: Colors.yellow ,
      color: Colors.green,),
    const ListViewItem(
      firstTitle: "BALANCE",
      secongTitle: "\$168.5 K",
      thirdTitle: "↑ 18.47",
      icon: Icons.balance,
      iconColor: Colors.black38 ,
      color: Colors.green,),

  ] ;

  final Completer<GoogleMapController> mainController =
  Completer<GoogleMapController>();

  BitmapDescriptor? customIcon ;

   CameraPosition mainPosition = const CameraPosition(
      target: LatLng(23.7985053,90.3842538 ),
      zoom: 15);

   Set<Marker> markers = <Marker>{};
   GoogleMapController? mapController ;
   bool themeDone = false ;

  void menuPressed () {
    isMeniPressed = !isMeniPressed ;
    notifyListeners();
  }

  void equalVerticalSwitch (bool value) {
    isVerticalSwitchPressed = value ;
    notifyListeners();
  }

  void equalHorizontalSwitch (bool value) {
    isHorizontalSwitchPressed = value ;
    notifyListeners();
  }

  void equalLightSwitch (bool value) {
    isLightSwitchPressed = value ;
    notifyListeners();
  }

  void equalDarkSwitch (bool value) {
    isDarkSwitchPressed = value ;
    notifyListeners();
  }

  void equalFluidSwitch (bool value) {
    isFluidSwitchPressed = value ;
    notifyListeners();
  }

  void equalBoxedSwitch (bool value) {
    isBoxedSwitchPressed = value ;
    notifyListeners();
  }

  void equalDetachedSwitch (bool value) {
    isDetachedSwitchPressed = value ;
    notifyListeners();
  }

  void equalUserInfoSwitch (bool value) {
    isUserInfoSwitchPressed = value ;
    notifyListeners();
  }

  void totalSalesMenuPressed () {
    isTotalSalesMenuPressed = !isTotalSalesMenuPressed ;
    notifyListeners();
  }

  void equalMapController (GoogleMapController controller) {
    mapController = controller ;
    notifyListeners();
  }

  void equalMapDone () {
    themeDone = true ;
    notifyListeners();
  }

  // void equalIconMarker () {
  //   BitmapDescriptor.asset(const ImageConfiguration(
  //     size: Size(12, 12)
  //   ), "assets/images/logo.png").then((value) {
  //     customIcon = value ;
  //     notifyListeners();
  //   });
  // }

  void addToMarkers () {
    markers.add(
      Marker(markerId: MarkerId("First position") ,
      position: LatLng(23.7985053,90.3842538 ) ,
      infoWindow: InfoWindow(title: "India") ,
      icon: BitmapDescriptor.defaultMarker),
    );
    notifyListeners();
  }

  // void addSecondMarker () {
  //   markers.add(
  //       Marker(markerId: MarkerId("Second position") ,
  //           position: LatLng(23.802236,90.3700 ) ,
  //           infoWindow: InfoWindow(title: "France") ,
  //           icon: BitmapDescriptor.defaultMarker)
  //   );
  //   notifyListeners();
  }
