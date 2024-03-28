import 'package:flutter/material.dart';

import '../Config.dart';
import '../Constants.dart';

Container FlatTextButton(BuildContext context, String text , double w, Color c) {

  return Container(

      height: SizeConfig.heightMultiplier * 6,
      width: w,
      decoration: circularEdges(
          SizeConfig.heightMultiplier * 2,
          SizeConfig.heightMultiplier * 2,
          SizeConfig.heightMultiplier * 2,
          SizeConfig.heightMultiplier * 2,
          c
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text,style: Theme.of(context).textTheme.headline5, ),
        ],
      )
  );
}