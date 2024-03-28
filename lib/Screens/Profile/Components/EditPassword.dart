
import '/Screens/ForgotPassword/ForgotPasswordScreen.dart';
import '/Screens/Profile/Components/titleSubtitle.dart';
import '/Screens/Profile/Model/ProfileModel.dart';
import 'package:flutter/material.dart';

import '../../../Config.dart';
import '../../../Constants.dart';
import '../../../string.dart';

Column passwordSection(BuildContext context, ProfileModel profile) {
  return Column(children: [

    Row(
      children: [

        SizedBox(width: SizeConfig.heightMultiplier * 2 ,),

        Icon(
          Icons.lock,
          color: kBase,
          size: SizeConfig.heightMultiplier * 3.5,
        ),


        SizedBox(width: SizeConfig.heightMultiplier * 2 ,),

        Text(english ? "Security" : m["Security"].toString(), style: Theme.of(context).textTheme.headline2?.copyWith(color: kBase , fontWeight: FontWeight.bold),),

        const Spacer(),

        InkWell(
            onTap:()=> editBasicProfile(context, profile),
            child: Icon( Icons.edit, color: kBase, )),

        SizedBox(width: SizeConfig.heightMultiplier * 2 ,),
      ],
    ),


    SizedBox(height: SizeConfig.heightMultiplier * 5 ,),

    titleSubtitle(english ? "Password" : m["Password"].toString(), "********"),

  ],);
}





void editBasicProfile(BuildContext context, ProfileModel profile){


  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => ForgotPassword(updatePass: true,)),
  );


}
