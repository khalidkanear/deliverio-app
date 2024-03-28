import 'package:flutter/material.dart';

import '../Config.dart';
import '../Constants.dart';

Widget buildFlatButton() {

  return Container(

    margin: EdgeInsets.all(kDefaultPadding),
    height: SizeConfig.heightMultiplier * 8,
    width: SizeConfig.heightMultiplier * 8,

    decoration: circularEdges(
        SizeConfig.heightMultiplier * 3,
        SizeConfig.heightMultiplier * 3,
        SizeConfig.heightMultiplier * 3,
        SizeConfig.heightMultiplier * 3,
        kOrange
    ),

    child: Icon(Icons.keyboard_arrow_right_rounded,size: SizeConfig.heightMultiplier * 5,),
  );

}