import '/Screens/Profile/Components/titleSubtitle.dart';
import '/Screens/Profile/Model/ProfileModel.dart';
import '/Screens/SignUp/VehicleDetails.dart';
import 'package:flutter/material.dart';

import '../../../Config.dart';
import '../../../Constants.dart';
import '../../../string.dart';



Column vehicle(BuildContext context,ProfileModel profile, bool noVehicle) {
  return Column(children: [

    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        SizedBox(width: SizeConfig.heightMultiplier * 2 ,),

        Icon(
          Icons.directions_bike_rounded,
          color: kBase,
          size: SizeConfig.heightMultiplier * 3.5,
        ),


        SizedBox(width: SizeConfig.heightMultiplier * 2 ,),

        Text(english ? "Vehicle Details" : m["Vehicle Details"].toString(), style: Theme.of(context).textTheme.headline2?.copyWith(color: kBase , fontWeight: FontWeight.bold),),

        const Spacer(),

        InkWell(
            onTap: ()=>editVehicle(context, profile, noVehicle),
            child: Icon( Icons.edit, color: kBase, )
        ),

        SizedBox(width: SizeConfig.heightMultiplier * 2 ,),
      ],
    ),

    SizedBox(height: SizeConfig.heightMultiplier * 5 ,),

    titleSubtitle(english ? "Make" : m["Make"].toString(), noVehicle ? "Not assigned" : profile.vehicle?.make.toString()),

    titleSubtitle(english ? "Model" : m["Model No."].toString(), noVehicle ? "Not assigned" : profile.vehicle?.model.toString()),

    titleSubtitle(english ? "Registration No" : m["Registration No."].toString(), noVehicle ? "Not assigned" : profile.vehicle?.regNo.toString()),

    SizedBox(height: SizeConfig.heightMultiplier,),

  ],);
}






void editVehicle(BuildContext context, ProfileModel profile , bool noVehicle){


  if(noVehicle){

    ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))
          ),

          elevation: 6,
          margin: EdgeInsets.all( SizeConfig.heightMultiplier * 5),
          backgroundColor: Colors.white,
          duration: const Duration(milliseconds: 6000),
          content: Container(
            padding: EdgeInsets.all(SizeConfig.heightMultiplier),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text("Permission denied, please contact Support for further details.",
                    style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: SizeConfig.heightMultiplier * 2.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ));

  }else{

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => VehicleDetails(true, profile)),
    );

  }



}