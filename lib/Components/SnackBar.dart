import 'package:flutter/material.dart';
import '../Config.dart';



showSnackBar(String message, GlobalKey<ScaffoldState> key ){

  ScaffoldMessenger.of(key.currentContext!).showSnackBar(

      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))
        ),

        elevation: 6,
        margin: EdgeInsets.all( SizeConfig.heightMultiplier * 5),
        backgroundColor: Colors.white,
        duration: const Duration(milliseconds: 4000),
        content: Container(
          padding: EdgeInsets.all(SizeConfig.heightMultiplier),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(message,
                  style: Theme.of(key.currentContext!).textTheme.headline3?.copyWith(fontSize: SizeConfig.heightMultiplier * 2.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ));
}