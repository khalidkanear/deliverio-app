import '/Config.dart';
import 'package:flutter/material.dart';



AppBar appBar(String ?title, BuildContext context, Color bg , Color fg){

  return AppBar(
    backgroundColor: bg,
    elevation: 0,
    leading: GestureDetector(
      onTap: ()=>Navigator.of(context).pop(),
      child: Icon(Icons.arrow_back_ios,color: fg,),
    ),
    title: Text(title??'', style: TextStyle(color: fg, fontFamily: 'Nunito', fontWeight: FontWeight.bold , fontSize: 2.5 * SizeConfig.heightMultiplier)),
  );
}