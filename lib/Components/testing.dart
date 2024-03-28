import 'package:flutter/material.dart';

import '../Config.dart';
import '../Constants.dart';

Widget testingDialog(BuildContext context, String data){




  return AlertDialog(
    elevation: 0,
    scrollable: true,
    insetPadding: EdgeInsets.symmetric(horizontal:SizeConfig.heightMultiplier * 2, vertical: kDefaultPadding * 2),
    contentPadding: const EdgeInsets.all(0),
    backgroundColor: Colors.white,
    content: Column(children: [


      Text(data),

    ],
    )

  );


}