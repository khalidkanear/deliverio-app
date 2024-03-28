import '/Config.dart';
import '/Constants.dart';
import 'package:flutter/material.dart';

Row buildCircularAvatar(double radius , String image) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircleAvatar(
        backgroundColor: kBase,
        radius: SizeConfig.heightMultiplier * 10,
        child: CircleAvatar(
          radius: SizeConfig.heightMultiplier * 8.5,
          child: ClipOval(
            child: Container(
              color: kGrey,
              height: radius,
              width: radius,
              child: Icon(Icons.person,color: kBase,size: SizeConfig.heightMultiplier * 8,) ,
            ),
          ),
        ),
      ),
    ],
  );
}