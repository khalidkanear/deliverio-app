import '/Screens/Profile/Components/titleSubtitle.dart';
import '/Screens/Profile/Model/ProfileModel.dart';
import '/Screens/SignUp/SignUp.dart';
import 'package:flutter/material.dart';

import '../../../Config.dart';
import '../../../Constants.dart';
import '../../../string.dart';

Column profileSection(BuildContext context, ProfileModel profile) {
  return Column(children: [

    Row(
      children: [

        SizedBox(width: SizeConfig.heightMultiplier * 2 ,),

        Icon(
          Icons.person,
          color: kBase,
          size: SizeConfig.heightMultiplier * 3.5,
        ),


        SizedBox(width: SizeConfig.heightMultiplier * 2 ,),

        Text(english ? "Basic Details" : m["Basic Details"].toString(), style: Theme.of(context).textTheme.headline2?.copyWith(color: kBase , fontWeight: FontWeight.bold),),

        const Spacer(),

        InkWell(
            onTap:()=> editBasicProfile(context, profile),
            child: Icon( Icons.edit, color: kBase, )),

        SizedBox(width: SizeConfig.heightMultiplier * 2 ,),
      ],
    ),


    SizedBox(height: SizeConfig.heightMultiplier * 5 ,),

    titleSubtitle(english ? "Mobile No." : m["Mobile No."].toString(), profile.phoneNo),

    titleSubtitle(english ? "Address" : m["Address"].toString(), profile.address),

    titleSubtitle(english ? "License No" : m ["License No."].toString(), profile.licenceNo),

    titleSubtitle(english ? "NRIC" : m["NRIC"].toString(), profile.nric),


    titleSubtitle(english ? "Bank Account No." : m["Bank Account No."].toString(), profile.bankAccountNo),

  ],);
}





void editBasicProfile(BuildContext context, ProfileModel profile){


  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => SignUp(true, profile)),
  );


}
