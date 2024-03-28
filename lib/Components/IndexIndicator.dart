import 'package:flutter/material.dart';
import '../Config.dart';
import '../Constants.dart';



Row buildIndexIndicator(int length, int activeIndex) {

  List<Widget> containers = [];

  for(int i = 0 ; i < length ; i++){
    containers.add(
        Container(
          margin: (i % 2 == 0) ? EdgeInsets.all(SizeConfig.heightMultiplier/2): const EdgeInsets.all(0),
          decoration: circularEdges(10, 10, 10, 10, (i == activeIndex) ? Colors.white : Colors.white.withOpacity(.5)),
          height: SizeConfig.heightMultiplier,
          width: (i == activeIndex) ? SizeConfig.heightMultiplier * 6 :  SizeConfig.heightMultiplier * 2,
        )
    );
  }


  return Row(children: [

    for ( var i in containers ) i

  ],);


}
