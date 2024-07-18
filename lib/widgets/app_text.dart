import 'package:flutter/cupertino.dart';

Widget appText ({required String text , required Color color , required double fontSize ,
  FontWeight? fontWeight , String? fontFamily , TextAlign textAlight = TextAlign.start}) {
  return Text(text , style: TextStyle(
      color: color ,
      fontSize: fontSize ,
      fontWeight: fontWeight ,
      fontFamily: fontFamily
  ),
    overflow: TextOverflow.ellipsis,
    textAlign: textAlight,
     maxLines: 3,);
}