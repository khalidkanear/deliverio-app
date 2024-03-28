import 'package:flutter/material.dart';
import '../../../Config.dart';
import '../../../Constants.dart';




Widget titleSubtitle(String label, value) {




  return Padding(
    padding: EdgeInsets.symmetric(horizontal : SizeConfig.imageSizeMultiplier * 5),
    child: ListTile(

      title:Text(
        label,
        style: TextStyle(
          fontSize: SizeConfig.heightMultiplier * 1.8,
          color: kBase,
          fontFamily: 'Nunito',
        ),
      ),
      subtitle:  Text(
       value,
        style: TextStyle(
          fontSize: SizeConfig.heightMultiplier * 2.2,
          color: Colors.black,
          fontFamily: 'Nunito',
        ),
      ),
    ),
  );
}
