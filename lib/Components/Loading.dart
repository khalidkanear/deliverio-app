import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Config.dart';


Widget loading = WillPopScope(child: AlertDialog(

    elevation: 0,
    backgroundColor: Colors.transparent,
    content: SizedBox(

      height: SizeConfig.heightMultiplier * 20,
      width: SizeConfig.heightMultiplier * 20,

      child: SpinKitDoubleBounce(
        size: 125,
        duration: const Duration(milliseconds: 1000),
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: index.isEven ? Colors.white : Colors.white.withOpacity(.5),
            ),
          );
        },
      ),
    ))
    , onWillPop: (){
  return Future.value();
    }
);